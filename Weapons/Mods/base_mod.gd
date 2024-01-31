extends Node2D
class_name BaseMod

signal mod_hitting(mod)

@onready var mod_texture = $ModTexture
var tooltip_text : String
var icon : CompressedTexture2D

var parent
var current_rank = 0

func _ready():
	parent = get_parent()

func refresh():
	pass
	
func remove_mod():
	queue_free()

func get_texture():
	return mod_texture

func get_tooltip_text():
	return tooltip_text

