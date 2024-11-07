extends CenterContainer

var START_MENU_SCENE = "res://UI/StartMenu/start_menu.tscn"

var current_button : Button

# ... other nodes and variables
@onready var move_up_keybind_button = $TabContainer/Keybinds/MarginContainer/VBoxKeybinds/HBoxContainer/MoveUpKeybindButton
@onready var move_down_keybind_button = $TabContainer/Keybinds/MarginContainer/VBoxKeybinds/HBoxContainer2/MoveDownKeybindButton
@onready var move_left_keybind_button = $TabContainer/Keybinds/MarginContainer/VBoxKeybinds/HBoxContainer3/MoveLeftKeybindButton
@onready var move_right_keybind_button = $TabContainer/Keybinds/MarginContainer/VBoxKeybinds/HBoxContainer4/MoveRightKeybindButton
@onready var instruction_panel = $TabContainer/Keybinds/MarginContainer/VBoxKeybinds/InstructionPanel




var button_name_dict = {"MoveUpKeybindButton": "move_up",
	"MoveDownKeybindButton" : "move_down",
	"MoveLeftKeybindButton" : "move_left",
	"MoveRightKeybindButton" : "move_right",
	}

func _ready():
	Hud.hide()
	move_up_keybind_button.pressed.connect(_on_button_pressed.bind(move_up_keybind_button))
	move_down_keybind_button.pressed.connect(_on_button_pressed.bind(move_down_keybind_button))
	move_left_keybind_button.pressed.connect(_on_button_pressed.bind(move_left_keybind_button))
	move_right_keybind_button.pressed.connect(_on_button_pressed.bind(move_right_keybind_button))

# Whenerver a button is pressed, do:
func _on_button_pressed(button: Button) -> void:
	current_button = button # assign clicked button to current_button
	instruction_panel.show() # show the panel with the info

func _input(event: InputEvent) -> void:
	if !current_button: # return if current_button is null
		return
		
	if event is InputEventKey || event is InputEventMouseButton:
		
		# This part is for deleting duplicate assignments:
		# Add all assigned keys to a dictionary
		var all_ies : Dictionary = {}
		for ia in InputMap.get_actions():
			for iae in InputMap.action_get_events(ia):
				all_ies[iae.as_text()] = ia
		
		# check if the new key is already in the dict.
		# If yes, delete the old one.
		if all_ies.keys().has(event.as_text()):
			InputMap.action_erase_events(all_ies[event.as_text()])
		
		# This part is where the actual remapping occures:
		# Erase the event in the Input map
		InputMap.action_erase_events(button_name_dict[current_button.name])
		# And assign the new event to it
		InputMap.action_add_event(button_name_dict[current_button.name], event)
		
		# After a key is assigned, set current_button back to null
		current_button = null
		instruction_panel.hide() # hide the info panel again
		
		_update_labels() # refresh the labels

func _update_labels() -> void:
	print("updating labels")
	
	for button in get_tree().get_nodes_in_group("keybind_buttons"):
		var eb1 : Array[InputEvent] = InputMap.action_get_events(button_name_dict[button.name])
		if !eb1.is_empty():
			button.text = eb1[0].as_text()
		else:
			button.text = ""


func _on_close_button_pressed():
	get_tree().change_scene_to_file(START_MENU_SCENE)
