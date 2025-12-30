extends Node2D

@export var player_name: String = "";
@export var uid: String = "";
@export var velocity: float = 50.0; # pixels per second

var state: Types.PlayerState;
var destination: Vector2 = position;
var home: Vector2;
var target: Cell = null;
var actionState: Types.PlayerState;
var count: int = 0;

func act(delta: float) -> void:
	match state:
		Types.PlayerState.IDLE:
			get_parent().remove_child(self);
			self.queue_free();
		Types.PlayerState.TRAVEL:
			if position.distance_squared_to(destination) <= 1.0 :
				if destination.is_equal_approx(home) : state = Types.PlayerState.IDLE;
				else : state = actionState;
			else :
				var direction = (destination - position).normalized();
				position += direction * delta * velocity;
		Types.PlayerState.GATHER:
			if $GatherTimer.is_stopped(): $GatherTimer.start(randf_range(2.0, 4.0));
		Types.PlayerState.SEARCH:
			if count < 5 :
				count += 1;
				var offset = Vector2(randf_range(-50.0, 50.0), randf_range(-50.0, 50.0));
				destination = target.to_global(target.rss.position + offset);
				state = Types.PlayerState.TRAVEL;
			elif count >= 5 :
				state = Types.PlayerState.HOME;
		Types.PlayerState.HOME:
			destination = home;
			state = Types.PlayerState.TRAVEL;

func search() -> void :
	state = Types.PlayerState.SEARCH;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text = player_name;
	$GatherTimer.connect("timeout", search, 2);

func action(_target: Cell, _state: Types.PlayerState) -> void:
	target = _target;
	actionState = _state;
	state = Types.PlayerState.SEARCH;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	act(delta);
