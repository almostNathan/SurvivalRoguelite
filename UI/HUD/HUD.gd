extends CanvasLayer

@onready var exp_bar = $ExperienceBar
@onready var player_level_label = $PlayerLevelBacksplash/PlayerLevelLabel
@onready var inventory = $Inventory
@onready var loot_menu = $LootMenu
@onready var config_weapons_screen = $ConfigureWeapons
@onready var health_bar = $HealthBar
@onready var level_up_menu = $LevelUpMenu
@onready var player_menu = $PlayerMenu
@onready var game_over_screen = $GameOverScreen

func _input(event):
	if event.is_action("menu_button") and not event.is_echo() and event.is_pressed():
		Hud.open_menu()

func update_health(cur_health):
	health_bar.value = cur_health

func get_exp_bar():
	return exp_bar

func get_player_level_label():
	return player_level_label

func level_up():
	level_up_menu.load_level_up_window()

func open_menu():
	if player_menu.is_open:
		player_menu.close_player_menu()
	elif get_tree().paused == false:
		player_menu.load_player_menu()

func game_over():
	game_over_screen.load_game_over_screen()
	print("youre dead")

func open_weapon_config():
	config_weapons_screen.open()
