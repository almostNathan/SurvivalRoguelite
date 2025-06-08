extends CanvasLayer

@onready var exp_bar = $ExperienceBar
@onready var player_level_label = $PlayerLevelBacksplash/PlayerLevelLabel
@onready var weapons_display = $WeaponsDisplay
@onready var loot_menu = $LootMenu
@onready var config_weapons_screen = $ConfigureWeapons
@onready var health_bar = $HealthBar
@onready var level_up_menu = $LevelUpMenu
@onready var player_menu = $PlayerMenu
@onready var game_over_screen = $GameOverScreen
@onready var time_capsule_screen = $TimeCapsuleScreen
@onready var loadout_selection_screen = $LoadoutSelectionScreen
@onready var damage_aura = $DamageAura

var menu_list = [player_menu, time_capsule_screen]


func _input(event):
	if event.is_action("menu_button") and not event.is_echo() and event.is_pressed():
		if time_capsule_screen.is_open:
			time_capsule_screen.close()
		else:
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

func open_weapon_config():
	config_weapons_screen.open()

func update_weapons_display():
	weapons_display.update()

func load_loot_menu():
	loot_menu.load_loot_menu()

func hide_for_hub():
	config_weapons_screen.hide()

func open_time_capsule():
	time_capsule_screen.open()

func load_loadout_selection_screen():
	loadout_selection_screen.load_select_loadout_screen()

func show_damage():
	damage_aura.show_damage()
	var opacity_tween = create_tween()
	damage_aura.visible = true
	opacity_tween.tween_property(damage_aura,"modulate:a", 1, .3)
	await opacity_tween.finished
	opacity_tween.tween_property(damage_aura,"modulate:a", 0, .3)
	await opacity_tween.finished
	damage_aura.visible = false
	opacity_tween.kill()

