extends BasePlayerMod
class_name IncreasedExperiencePlayerMod

var experience_multiplier = .5

func set_base_data():
	mod_name = "Increased Experience"
	tooltip_text = "Increased Experience Mod"
	icon = preload("res://Art/Drops/increased_experience_player_mod.png")


func equip(player : Player):
	super(player)
	player.modify_experience_multiplier(experience_multiplier)


func remove_mod():
	player.modify_experience_multiplier(-experience_multiplier)
