extends CanvasLayer

@onready var exp_bar = $ExperienceBar
@onready var player_level_label = $PlayerLevelBacksplash/PlayerLevelLabel
@onready var inventory = $Inventory
@onready var loot_menu = $LootMenu
@onready var health_bar = $HealthBar

func update_health(cur_health):
	health_bar.value = cur_health

func get_exp_bar():
	print("hud getexpbar ", exp_bar)
	return exp_bar

func get_player_level_label():
	return player_level_label


