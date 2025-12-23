extends Node2D

@export var CELLS_WIDE: int = 3;
@export var CELLS_HIGH: int = 3;

const CELL_SCENE = preload("res://containers/cell.tscn");
const PLAYER_SCENE = preload("res://entities/player.tscn");

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Cells.position = Vector2(0, 0);
	var cellCount = CELLS_WIDE * CELLS_HIGH;
	for i in range(cellCount) :
		var cell = CELL_SCENE.instantiate();
		cell.id = i;
		cell.width = get_viewport().size.x / CELLS_WIDE;
		cell.height = get_viewport().size.y / CELLS_HIGH;
		cell.CELLS_HIGH = CELLS_HIGH;
		cell.CELLS_WIDE = CELLS_WIDE;
		$Cells.add_child(cell);
	for i in range(5) :
		var player = PLAYER_SCENE.instantiate();
		player.player_name = "Player %s" % [i];
		player.position = Vector2(330.0, 330.0);
		var _cell = $Cells.get_children()[randi_range(0, cellCount - 1)];
		player.setDestination(_cell.position);
		$Players.add_child(player);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
