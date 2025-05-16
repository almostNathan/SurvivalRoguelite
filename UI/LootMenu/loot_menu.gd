extends PanelContainer
class_name LootMenu

@onready var loot_selection_area = $MarginContainer/VBoxContainer/LootSelectionArea

var player
var selection_count = 3
var level_up_selection = preload("res://UI/LootSelection/loot_selection.tscn")

func load_loot_menu():
	var loot_scene_list = AllModList.mod_scene_list.duplicate()
	player = Globals.player
	var loot_selection_options = []
	for mod in range(selection_count):
		var selected_loot_scene = loot_scene_list.pick_random()
		loot_selection_options.append(selected_loot_scene.instantiate())
		loot_scene_list.remove_at(loot_scene_list.find(selected_loot_scene))

	for loot in loot_selection_options:
		var new_selection = level_up_selection.instantiate()
		loot_selection_area.add_child(new_selection)
		new_selection.set_selection(loot)
		new_selection.selection_made.connect(selection_made)

	get_tree().paused = true
	visible = true

func selection_made():
	clear_selections()
	get_tree().paused = false
	visible = false

func clear_selections():
	for selection in loot_selection_area.get_children():
		loot_selection_area.remove_child(selection)
		selection.queue_free()

func _on_reroll_button_pressed():
	clear_selections()
	load_loot_menu()
