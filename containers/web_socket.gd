extends Node

var websocket_url = "ws://localhost:8008";
var socket = WebSocketPeer.new();
signal commands(data: Array);
const HEARTBEAT_INTERVAL = 45.0;

func acknowledge(commands: Array) -> void:
	if socket.get_ready_state() != WebSocketPeer.STATE_OPEN:
		return;
	
	var obj: Dictionary = {};
	obj.action = "ack";
	obj.commands = commands;
	socket.send_text(JSON.stringify(obj));
func registerSession(id: String) -> void:
	if socket.get_ready_state() != WebSocketPeer.STATE_OPEN:
		return;

	var obj: Dictionary = {};
	obj.action = "register";
	obj.sessionId = id;
	socket.send_text(JSON.stringify(obj));

func _ready() -> void:
	#socket.set_heartbeat_interval(HEARTBEAT_INTERVAL);
	var err = socket.connect_to_url(websocket_url);
	if err != OK:
		push_error("Unable to connect");
		set_process(false);

func _process(_delta: float) -> void:
	socket.poll();
	var state = socket.get_ready_state();
	
	match (state):
		WebSocketPeer.STATE_OPEN:
			while socket.get_available_packet_count():
				var packet = socket.get_packet();
				var obj = JSON.parse_string(packet.get_string_from_utf8());
				match (obj.action):
					"ack":
						print("server acknowledged:", obj.sessionId);
					"commands":
						commands.emit(obj.commands);
		WebSocketPeer.STATE_CLOSING:
			pass;
		WebSocketPeer.STATE_CLOSED:
			commands.emit([{ "commandName": "game-end" }]);
			set_process(false);
