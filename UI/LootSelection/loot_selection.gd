extends MarginContainer
class_name LootSelection

@onready var selection_icon = $SelectionContainer/MarginContainer/MarginContainer/SelectionIcon
@onready var selection_label = $ColorRect/SelectionLabel
@onready var border = $SelectionContainer/SelectionBorder
@onready var rarity_border = $SelectionContainer/MarginContainer/RarityBorder
@onready var tooltip = $Tooltip

var mod_in_selection 
signal selection_made()

func set_selection(mod):
	if mod is BaseMod:
		border.color = Color(0, 0, .9, 1)
		rarity_border.color = Globals.rarity_colors[mod.rarity]
		tooltip.set_text(mod.get_tooltip_description())
	if mod is BaseWeapon:
		border.color = Color(180,0,0,255)
		rarity_border = Color(0,0,0,255)
	if mod is BasePlayerMod:
		border.color = Color(180,0,180,255)
		rarity_border = Color(0,0,0,255)
	mod_in_selection = mod
	selection_icon.texture = mod.icon
	selection_label.text = mod.get_object_name()


func _on_selection_icon_gui_input(event):
	if event is InputEventMouseButton:
		if mod_in_selection is BaseMod:
			Globals.player.add_to_inventory(mod_in_selection)
			selection_made.emit()
		if mod_in_selection is BaseWeapon:
			Globals.player.add_to_weapon_inventory(mod_in_selection)
			AllWeaponList.remove_weapon_from_pool(mod_in_selection)
			selection_made.emit()
		if mod_in_selection is BasePlayerMod:
			Globals.player.add_mod(mod_in_selection)
			selection_made.emit()

func _on_mouse_entered():
	tooltip.toggle(true)


func _on_mouse_exited():
	tooltip.toggle(false)
