extends Node2D

const PLAYER_SCENE = preload("res://entities/player.tscn");
enum Map { MAIN_MENU, GATHER, BUILD, BATTLE };
const MAP_LOOKUP = {
	Map.GATHER: preload("res://maps/gather.tscn"),
	Map.BUILD: preload("res://maps/build.tscn"),
	Map.BATTLE: preload("res://maps/battle.tscn"),
	Map.MAIN_MENU: preload("res://maps/mainMenu.tscn"),
};
var map = null;

func handleCommands(commands: Array) -> void:
	var response = [];
	for command in commands:
		match command.commandName:
			"ad-start":
				print("ad start");
			"ad-end":
				print("ad end");
			"game-start":
				print("game start");
			"game-end":
				print("game end");
				#TODO: clear game state
				changeMap(Map.MAIN_MENU);
			"gather":
			#"deliver":
			#"attack":
				var player = command.params.player;
				var args = command.params.args;
				response.push_back({
					"uid": player.uid,
					"status":  "SUCCESS" if playerAction(player.uid, player.username, args[0], "") else "FAILURE",
				});
	$WebSocket.acknowledge(response);
	
func handleSession(id: String) -> void:
	# TODO: error handle for bad session
	$WebSocket.registerSession(id);
	changeMap(Map.GATHER);
func changeMap(mapType: Map) -> void:
	if map :
		remove_child(map);
		map.queue_free();
	map = MAP_LOOKUP[mapType].instantiate();
	add_child(map);
	match mapType:
		Map.MAIN_MENU:
			map.session_id.connect(handleSession);
func playerAction(uid: String, playerName: String, cell: String, rss: String) -> bool:
	for player in $Players.get_children():
		if player.uid == uid: return false;

	var player = PLAYER_SCENE.instantiate();
	player.uid = uid;
	player.position = map.hub_location;
	player.player_name = playerName;
	player.home = map.hub_location;
	$Players.add_child(player);
	player.action(map.getCells()[cell.to_int()], Types.PlayerState.GATHER);
	return true;

func _ready() -> void:
	$WebSocket.commands.connect(handleCommands);
	changeMap(Map.MAIN_MENU);

func _process(_delta: float) -> void:
	pass
