extends Node2D
class_name BasePlayerMod


var mod_name = "Base"
var tooltip_text : String = ""
var tooltip_description : String = ""
var icon : CompressedTexture2D
var current_rank = 1
var player : Player

func _init():
	set_base_data()

func set_base_data():
	pass

func get_tooltip_text():
	return tooltip_text

func get_tooltip_description():
	return tooltip_description

func equip(player : Player):
	self.player = player

func get_object_name():
	return mod_name

func remove_mod():
	pass

func refresh():
	pass

func apply_effect_to_weapon(weapon):
	pass
	
func remove_effect_from_weapon(weapon):
	pass
