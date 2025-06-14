extends BasePlayerMod
class_name TimeCapsulePlayerMod

func set_base_data():
	mod_name = "Time Capsule"
	tooltip_text = "Time Capsule Player Mod"
	icon = preload("res://Art/Drops/deploy_speed_player_mod.png")

func equip(player : Player):
	super(player)
	player.reset_game.connect(_trigger_mod)

func _trigger_mod():
	var mod_list = player.get_all_weapon_mods_list()
	var selected_mod = mod_list.pick_random()
	var duplicate_mod = selected_mod.duplicate(DUPLICATE_USE_INSTANTIATION)
	Globals.player_data["rollover_mods"].append(duplicate_mod)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
