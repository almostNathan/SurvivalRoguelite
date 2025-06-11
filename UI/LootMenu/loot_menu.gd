extends PanelContainer
class_name LootMenu

@onready var loot_selection_area = $MarginContainer/VBoxContainer/LootSelectionArea

var player : Player
var selection_count = 3
var level_up_selection = preload("res://UI/LootSelection/loot_selection.tscn")
var current_filter_criteria = []

func load_loot_menu(filter_criteria = []):
	current_filter_criteria = filter_criteria
	#var loot_scene_list = AllModList.mod_scene_list.duplicate()
	var loot_data = AllModList.mod_data.duplicate()
	if len(loot_data) != len(AllModList.mod_scene_list):
		print("loot_menu mismatch ", len(loot_data), ' ', len(AllModList.mod_scene_list))
	player = Globals.player
	
	#Create the pool of mods to select from
	var loot_data_list = []
	if len(filter_criteria) == 0:
		loot_data_list = loot_data
	else:
		for data_dict in loot_data:
			if match_filter_criteria(filter_criteria, data_dict['tags']):
				loot_data_list.append(data_dict)

	#Pick the mods to serve to player
	var loot_selection_options = []
	for mod in range(selection_count):
		var selection_rarity = select_rarity()
		var selected_rarity_mod_data = loot_data_list.filter(func(mod_data): return mod_data["rarity"] == selection_rarity)
		var selected_loot_scene = load(selected_rarity_mod_data.pick_random()["scene_path"])
		loot_selection_options.append(selected_loot_scene.instantiate())
		#check if there are enough of the current rarity to 
		if len(loot_data_list) >= len(selected_rarity_mod_data):
			loot_data_list.remove_at(loot_data_list.find(selected_rarity_mod_data))
	
	#Draw loot selection areas.
	for loot in loot_selection_options:
		var new_selection = level_up_selection.instantiate()
		loot_selection_area.add_child(new_selection)
		new_selection.set_selection(loot)
		new_selection.selection_made.connect(selection_made)

	get_tree().paused = true
	visible = true

func match_filter_criteria(filter_criteria: Array, tag_array : Array):
	for criteria in filter_criteria:
		if tag_array.has(criteria):
			return true
	return false

func select_rarity() -> String:
	var current_rarity_distribution = Globals.get_current_rarity_distribuion()
	var rarity_roll = randf()
	for key in current_rarity_distribution:
		var value = current_rarity_distribution[key]
		if value > rarity_roll:
			return key
		else:
			rarity_roll -= value
	return "common"

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
	load_loot_menu(current_filter_criteria)
