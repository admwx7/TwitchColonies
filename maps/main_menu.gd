extends Control
signal session_id(id: String);

func emitIdChange() -> void:
	session_id.emit($SessionIdInput.text);
func _ready() -> void:
	$Button.pressed.connect(emitIdChange);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
