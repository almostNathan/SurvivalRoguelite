extends MarginContainer
class_name InventoryModSlot

signal displaying_tooltip(showing)

@onready var rank_label = $RankLabel
@onready var tooltip = $Tooltip


var mod_in_slot
var is_dragged = false
var tooltip_enabled = true

func _get_drag_data(_at_position):
	is_dragged = true
	modulate.a = 1
	set_drag_preview(duplicate())
	return mod_in_slot

func _can_drop_data(_at_position, data):
	if data is BaseMod and mod_in_slot.has_method('can_upgrade') and  mod_in_slot.can_upgrade(data):
		return true

func _drop_data(_at_position, data):
	if data is BaseMod and mod_in_slot.can_upgrade(data):
		mod_in_slot.upgrade_mod(data)
		rank_label.text = str(mod_in_slot.current_rank)

func set_mod_in_slot(mod):
	mod_in_slot = mod
	$Icon.texture = mod_in_slot.icon
	rank_label.text = str(mod_in_slot.current_rank)
	tooltip.set_text(mod_in_slot.get_tooltip_description())

func get_mod():
	return mod_in_slot

func _notification(what):
	match what:
		NOTIFICATION_DRAG_END:
			if (is_drag_successful() && is_dragged):
				#if mod_in_slot.is_equipped:
					#mod_in_slot.weapon.remove_mod(mod_in_slot)
					#print("inventorymodslot ", mod_in_slot, mod_in_slot.weapon)
				#remove_mod_from_inventory(mod_in_slot)
				mod_in_slot.unequip()
				get_parent().remove_child(self)
				is_dragged = false
			elif is_dragged:
				modulate.a = 1
				is_dragged = false

func enable_tooltip(enabled : bool):
	tooltip_enabled = enabled


func _on_mouse_entered():
	if tooltip_enabled:
		displaying_tooltip.emit(true)
		tooltip.toggle(true)


func _on_mouse_exited():
	if tooltip_enabled: 
		displaying_tooltip.emit(false)
		tooltip.toggle(false)

