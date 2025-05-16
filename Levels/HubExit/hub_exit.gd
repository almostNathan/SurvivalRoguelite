extends Area2D
class_name HubExit

signal change_scene(new_scene_path)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func interact():
	#get_tree().change_scene_to_file("res://main.tscn")
	change_scene.emit("res://main.tscn")


