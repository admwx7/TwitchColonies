class_name Cell
extends Node2D

@export var width: float = 0.0;
@export var height: float = 0.0;

const line_size: float = 64.0;
const RSS_SCENE = preload("res://entities/resource.tscn");

var discovered: bool = false;
var rss_depleted = false;
var rss: Node2D = null;

enum CellType { RESOURCE };

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rssRefresh();
	$Timer.connect("timeout", rssRefresh);
	$Line2D.position = Vector2(0.0, 0.0);
	$Line2D.scale = Vector2(width / line_size, height / line_size);

func harvest(player: Node2D) -> void:
	pass;
	if (rss_depleted && discovered) :
		# go home
		pass;
	if (discovered) :
		# wander around RSS for 30s, go home
		#player.addDestination();
		pass;
	else :
		# wander cell for 30s, go home
		#player.addDestination();
		pass;

func rssDepleted() -> void:
	$Timer.start(randf_range(30.0, 60.0));

func rssRefresh() -> void:
	rss = RSS_SCENE.instantiate();
	# TODO: offset by size / 2 of RSS
	rss.position = Vector2(randf_range(0, width), randf_range(0, height));
	add_child(rss);
	rss.visible = true;
