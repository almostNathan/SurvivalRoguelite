extends MarginContainer

@onready var selection_icon = $SelectionIcon
var mod_in_selection : BaseMod
signal selection_made()

func set_selection(mod):
	mod_in_selection = mod
	selection_icon.texture = mod.icon
	tooltip_text = mod.tooltip_text


func _on_selection_icon_gui_input(event):
	if event is InputEventMouseButton:
		Globals.player.add_to_inventory(mod_in_selection)
		selection_made.emit()
		
