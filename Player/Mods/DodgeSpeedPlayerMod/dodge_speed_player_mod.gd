extends BasePlayerMod
class_name DodgeSpeedPlayerMod

var dodge_speed_multiplier = .5

func _init():
	tooltip_text = "Dodge Speed Mod"
	icon = preload("res://Art/Drops/dodge_speed_player_mod.png")


func equip(player : Player):
	super(player)
	player.modify_dodge_speed_multiplier(dodge_speed_multiplier)


func remove_mod():
	player.modify_dodge_speed_multiplier(-dodge_speed_multiplier)
