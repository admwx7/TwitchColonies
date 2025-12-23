extends Node2D

@export var id: int = 0;
@export var width: float = 0.0;
@export var height: float = 0.0;
@export var discovered: bool = false;
@export var CELLS_WIDE: int;
@export var CELLS_HIGH: int;

const size: float = 64.0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.connect("timeout", rssRefresh);
	position.x = (int)(width * (id % CELLS_WIDE));
	position.y = (int)(height * (floori(id / 3.0) % CELLS_HIGH));
	$Line2D.position = Vector2(0.0, 0.0);
	$Line2D.scale = Vector2(width / size, height / size);

func rssDepleted() -> void:
	$Timer.start(randf_range(30.0, 60.0));

func rssRefresh() -> void:
	pass;
