extends BasePlayerMod
class_name MoveSpeedPlayerMod

var movespeed_multiplier = .2

func _init():
	tooltip_text = "Move Speed Mod"
	icon = preload("res://Art/Drops/movespeed_player_mod.png")


func equip(player : Player):
	super(player)
	player.modify_speed_multiplier(movespeed_multiplier)


func remove_mod():
	player.modify_speed_multiplier(-1 * movespeed_multiplier)
