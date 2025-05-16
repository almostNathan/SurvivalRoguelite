extends Control
class_name TimeCapsuleScreen

var is_open = false

@onready var mod_container = $HBoxContainer/ModContainer
@onready var player_menu = $HBoxContainer/PlayerMenu

var mod_slot_scene = preload("res://UI/Inventory/InventoryModSlot/inventory_mod_slot.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func open():
	player_menu.load_player_menu()
	for mod in Globals.player_data["rollover_mods"]:
		var new_mod_slot = mod_slot_scene.instantiate()
		mod_container.add_child(new_mod_slot)
		new_mod_slot.set_mod_in_slot(mod)
		new_mod_slot.custom_minimum_size = Vector2(50, 50)

	get_tree().paused = true
	visible = true
	is_open = true

func close():
	player_menu.close_player_menu()
	for mod_slot in mod_container.get_children():
		mod_container.remove_child(mod_slot)
		mod_slot.queue_free()
	
	
	Hud.update_weapons_display()
	get_tree().paused = false
	visible = false
	is_open = false
