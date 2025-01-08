extends Node2D
class_name BasePlayerMod


var tooltip_text : String
var icon : CompressedTexture2D
var current_rank = 1
var player : Player

func get_tooltip_text():
	return tooltip_text

func equip(player : Player):
	self.player = player

func remove_mod():
	pass

func refresh():
	pass

func apply_effect_to_weapon(weapon):
	pass
	
func remove_effect_from_weapon(weapon):
	pass
