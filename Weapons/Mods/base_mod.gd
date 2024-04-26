extends Node2D
class_name BaseMod

signal mod_hitting(mod)


var tooltip_text : String
var icon : CompressedTexture2D

var weapon
var current_rank = 1


func equip(new_weapon):
	self.weapon = new_weapon
	refresh()

func refresh():
	pass
	
func remove_mod():
	pass

func can_upgrade(new_mod):
	print(new_mod.name)
	if new_mod.name == self.name and new_mod.current_rank == self.current_rank and new_mod != self:
		return true
	else:
		return false

func upgrade_mod(new_mod):
	if can_upgrade(new_mod):
		current_rank += 1
		refresh()

func get_tooltip_text():
	return tooltip_text

