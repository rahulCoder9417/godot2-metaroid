extends Area2D

var direction:Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
func setup(pos:Vector2,dir:Vector2):
	position = pos +dir *16
	direction = dir
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position +=direction*50*delta
