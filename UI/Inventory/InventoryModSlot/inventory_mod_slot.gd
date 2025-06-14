extends MarginContainer
class_name InventoryModSlot

@onready var rank_label = $RankLabel
@onready var tooltip = $Tooltip


var mod_in_slot
var is_dragged = false


func _get_drag_data(_at_position):
	is_dragged = true
	self.modulate.a = 1
	set_drag_preview(self.duplicate())
	return mod_in_slot

func _can_drop_data(_at_position, data):
	if data is BaseMod and mod_in_slot.has_method('can_upgrade') and  mod_in_slot.can_upgrade(data):
		return true

func _drop_data(_at_position, data):
	#TODO Handle adding mods that upgrade.
	if data is BaseMod and mod_in_slot.can_upgrade(data):
		mod_in_slot.upgrade_mod(data)
		rank_label.text = str(mod_in_slot.current_rank)

func set_mod_in_slot(mod):
	mod_in_slot = mod
	$Icon.texture = mod_in_slot.icon
	tooltip_text = mod_in_slot.get_tooltip_text()
	rank_label.text = str(mod_in_slot.current_rank)
	await tooltip.ready
	tooltip.set_text("[center][b]{name}[/b][/center]\n".format({"name": mod.mod_name}) \
		+ "[center][b]{tooltip}[/b][/center]\n".format({"tooltip": mod.tooltip_text}))

func get_mod():
	return mod_in_slot

func _notification(what):
	match what:
		NOTIFICATION_DRAG_END:
			if (self.is_drag_successful() && is_dragged):
				#remove_mod_from_inventory(mod_in_slot)
				get_parent().remove_child(self)
				is_dragged = false
			elif is_dragged:
				self.modulate.a = 1
				is_dragged = false

func _on_tooltip_mouse_entered():
	tooltip.toggle(true)


func _on_tooltip_mouse_exited():
	tooltip.toggle(false)
