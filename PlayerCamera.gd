extends Camera2D

@export var bounding_rect : ColorRect

# Called when the node enters the scene tree for the first time.
func _ready():
	position = get_parent().position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
