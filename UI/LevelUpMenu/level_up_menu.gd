extends PanelContainer
class_name LevelUpMenu

@onready var mod_selection_area = $MarginContainer/ModSelectionArea

var player
var mod_scene_list = AllModList.mod_scene_list
var selection_count = 3
var level_up_selection = preload("res://UI/LevelUpSelection/level_up_selection.tscn")

func load_level_up_window():
	player = Globals.player
	var mod_selection_options = []
	for mod in range(selection_count):
		mod_selection_options.append(mod_scene_list.pick_random().instantiate())
	
	for mod in mod_selection_options:
		var new_selection = level_up_selection.instantiate()
		mod_selection_area.add_child(new_selection)
		new_selection.set_selection(mod)
		new_selection.selection_made.connect(selection_made)

	get_tree().paused = true
	visible = true

func selection_made():
	for selection in mod_selection_area.get_children():
		mod_selection_area.remove_child(selection)
		selection.queue_free()
		
	get_tree().paused = false
	visible = false
