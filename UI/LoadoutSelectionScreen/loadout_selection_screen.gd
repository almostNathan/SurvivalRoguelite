extends PanelContainer
class_name LoadoutSelectionScreen

@onready var loadout_hbox = $HBoxContainer

var loadout_selection_scene = preload("res://UI/LoadoutSelectionScreen/LoadoutSelection/loadout_selection.tscn")
var loadout_options = LoadoutOptions.new()



func load_select_loadout_screen():
	var loadout_list = loadout_options.starting_loadouts_list
	
	#Make Select mods/weapons
	for loadout in loadout_list:
		var new_loadout_selection = loadout_selection_scene.instantiate()
		loadout_hbox.add_child(new_loadout_selection)
		new_loadout_selection.set_loadout_selection(loadout)
		new_loadout_selection.loadout_button_pressed.connect(_selection_made)
		
		#
	#for mod in range(selection_count):
		#var selected_mod = mod_scene_list.pick_random()
		#mod_selection_options.append(selected_mod.instantiate())
		#mod_scene_list.remove_at(mod_scene_list.find(selected_mod))
#
	##Create selection Nodes
	#for mod in mod_selection_options:
		#var new_selection = level_up_selection.instantiate()
		#mod_selection_area.add_child(new_selection)
		#new_selection.set_selection(mod)
		#new_selection.selection_made.connect(selection_made)

	get_tree().paused = true
	visible = true

func _selection_made(loadout_data):
	var player : Player = Globals.player
	var loadout_weapon = loadout_data["loadout_weapon_scene"].instantiate()
	for mod_scene in loadout_data["loadout_mod_scene_list"]:
		loadout_weapon.add_mod(mod_scene.instantiate())
		
	player.add_to_weapon_inventory(loadout_weapon)
	
	if loadout_data["loadout_option_data"].has("additional_weapons"):
		for weapon in loadout_data["loadout_option_data"]["additional_weapons"]:
			player.add_to_weapon_inventory(weapon.instantiate())
			
	if loadout_data["loadout_option_data"].has("player_mod_list"):
		for mod_scene in loadout_data["loadout_option_data"]["player_mod_list"]:
			player.add_mod(mod_scene.instantiate())
	
	AllWeaponList.remove_weapon_from_pool(loadout_weapon)


	#Clear screen
	for selection_option in loadout_hbox.get_children():
		loadout_hbox.remove_child(selection_option)
		selection_option.queue_free()


	visible = false
	get_tree().paused = false
