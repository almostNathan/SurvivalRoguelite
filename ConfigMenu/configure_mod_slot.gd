extends MarginContainer
class_name ConfigureModSlot

var mod_in_slot : BaseMod

func _get_drag_data(at_position):
	set_drag_preview(self.duplicate())
	if get_parent().name == "WeaponModGridContainer":
		queue_free()
	return mod_in_slot.duplicate()

func set_mod_in_slot(mod):
	mod_in_slot = mod
	$Texture.texture = mod_in_slot.icon
	tooltip_text = mod_in_slot.get_tooltip_text()

func get_mod():
	return mod_in_slot
