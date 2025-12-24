extends Node2D

const PLAYER_SCENE = preload("res://entities/player.tscn");
enum Map { GATHER, BUILD, BATTLE };
const MAP_LOOKUP = {
	Map.GATHER: preload("res://maps/gather.tscn"),
	Map.BUILD: preload("res://maps/build.tscn"),
	Map.BATTLE: preload("res://maps/battle.tscn"),
};
var map: Node2D = null;

func changeMap(mapType: Map) -> void:
	if map :
		remove_child(map);
		map.queue_free();
	map = MAP_LOOKUP[mapType].instantiate();
	add_child(map);
func playerAction(playerName: String, cell: int, rss: String) -> void:
	var player = PLAYER_SCENE.instantiate();
	player.position = map.hub_location;
	player.player_name = playerName;
	player.home = map.hub_location;
	$Players.add_child(player);
	player.action(map.getCells()[cell], Types.PlayerState.GATHER);

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	changeMap(Map.GATHER);

	var cells = map.getCells();
	for i in range(10) :
		playerAction("Player %s" % [i], randi_range(0, cells.size() - 1), "");

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
