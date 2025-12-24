extends Node2D

var resource_type: String = "";
var quantity: int;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomizeRss();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func randomizeRss() -> void:
	var cell = get_parent()
	position = Vector2(randf_range(0, cell.width), randf_range(0, cell.height));
