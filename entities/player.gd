extends Node2D

@export var player_name: String = "";
@export var screen_name: String = "";
@export var velocity: float = 50.0; # pixels per second

enum State { IDLE, RUNNING };
var state: State = State.IDLE;
var destination: Vector2 = position;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text = player_name;

func setDestination(dest: Vector2) -> void :
	if (state == State.IDLE) : destination = dest;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (destination == position) :
		state = State.IDLE;
	else : # TODO: would be nice to ramp up and ramp down speeds when starting / ending movement
		state = State.RUNNING;
		var direction = (destination - position).normalized();
		position += direction * delta * velocity;
