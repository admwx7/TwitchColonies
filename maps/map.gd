extends Node2D

@export var hub_location: Vector2;

const HUB_SCENE = preload("res://entities/hub.tscn");

func getCells() -> Array[Node]:
	return $Cells.get_children();

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var hub = HUB_SCENE.instantiate();
	hub.position = hub_location;
	add_child(hub);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
