extends Control

# Path constants for scene transitions
const GAME_SCENE = "res://main.tscn"
const HUB_SCENE = "res://Levels/Hub/hub.tscn"
const OPTIONS_SCENE = "res://UI/SettingsMenu/settings_menu.tscn"
const COLLECTION_SCENE = "res://scenes/collection.tscn"

# Button colors
const COLOR_START = Color("2ecc71")  # Green
const COLOR_OPTIONS = Color("3498db")  # Blue
const COLOR_COLLECTION = Color("e74c3c")  # Red
const HOVER_BRIGHTNESS = 1.2

@onready var start_button = $HBoxContainer/StartButton
@onready var options_button = $HBoxContainer/OptionsButton
@onready var collection_button = $HBoxContainer/CollectionButton

# Called when the node enters the scene tree
func _ready():
	get_tree().paused = false
	# Set up animations and initial state
	Hud.hide()
	_setup_buttons()
	_setup_background()
	
	# Play background music if available
	#if $BackgroundMusic:
		#$BackgroundMusic.play()

func _setup_buttons():
	# Connect button signals
	var buttons = {
		$HBoxContainer/StartButton: COLOR_START,
		$HBoxContainer/OptionsButton: COLOR_OPTIONS,
		$HBoxContainer/CollectionButton: COLOR_COLLECTION
	}
	#$HBoxContainer/CollectionButton.pressed.connect(_on_collection_pressed)
	start_button.pressed.connect(_on_start_pressed)
	options_button.pressed.connect(_on_options_pressed)
	
	# Add hover animations
	for button : Button in $HBoxContainer.get_children():
		var style = StyleBoxFlat.new()
		style.bg_color = buttons[button]
		style.corner_radius_top_left = 15
		style.corner_radius_top_right = 15
		style.corner_radius_bottom_left = 15
		style.corner_radius_bottom_right = 15
		
		# Add emboss effect
		style.shadow_color = buttons[button].darkened(0.3)
		style.shadow_size = 4
		style.shadow_offset = Vector2(2, 2)
		
		# Add glow
		style.set_border_width_all(2)
		style.border_color = Color.WHITE
		style.set_expand_margin_all(5)
		
		# Create hover style
		var hover_style = style.duplicate()
		hover_style.bg_color = buttons[button].lightened(0.2)
		
		# Apply styles
		button.add_theme_stylebox_override("normal", style)
		button.add_theme_stylebox_override("hover", hover_style)
		button.add_theme_stylebox_override("pressed", style)
		
		# Set button size and font
		button.custom_minimum_size = Vector2(200, 60)
		
		# Set up text style
		button.add_theme_color_override("font_color", Color.WHITE)
		button.add_theme_color_override("font_pressed_color", Color.WHITE)
		button.add_theme_font_size_override("font_size", 24)
		
		# Add glow effect node
		var glow = RichTextEffect.new()
		var glow_parent = Node2D.new()
		button.add_child(glow_parent)
		glow_parent.z_index = -1
		
		button.pivot_offset = button.size/2
		button.mouse_entered.connect(_on_button_hover.bind(button))
		button.mouse_exited.connect(_on_button_normal.bind(button))

func _setup_background():
	# Create a tween for background effects
	var tween = get_tree().create_tween()
	if tween:
		tween.tween_property($Background, "modulate", Color(1, 1, 1, 1), 2.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		tween.play()

func _on_start_pressed():
	# Add transition animation
	#_play_button_press_sound()
	_transition_to_scene(HUB_SCENE)
	Hud.show()

func _on_options_pressed():
	#_play_button_press_sound()
	_transition_to_scene(OPTIONS_SCENE)
	Hud.show()

func _on_collection_pressed():
	#_play_button_press_sound()
	_transition_to_scene(COLLECTION_SCENE)
	Hud.show()

#func _play_button_press_sound():
	#if $ButtonSound:
		#$ButtonSound.play()

func _transition_to_scene(scene_path):
	## Add fade out animation
	#var transition = get_node("TransitionLayer/AnimationPlayer")
	#if transition:
		#transition.play("fade_out")
		#await transition.animation_finished
	
	# Change scene
	get_tree().change_scene_to_file(scene_path)

func _on_button_hover(button):
	# Scale up button slightly
	var tween = get_tree().create_tween()
	if tween:
		tween.tween_property(button, "scale", Vector2(1.1, 1.1), 0.1)
		tween.set_trans(Tween.TRANS_SINE)
		tween.set_ease(Tween.EASE_OUT)
		tween.play()

func _on_button_normal(button):
	# Reset button scale
	var tween = get_tree().create_tween()
	if tween:
		tween.tween_property(button, "scale", Vector2(1, 1), 0.1)
		tween.set_trans(Tween.TRANS_SINE)
		tween.set_ease(Tween.EASE_OUT)
		tween.play()
