extends BasePlayerMod
class_name MagnetRadiusPlayerMod

var magnet_radius_multiplier = .5

func set_base_data():
	mod_name = "Increased Magnet Radius"
	tooltip_text = "Increased Pickup Radius Mod"
	icon = preload("res://Art/Drops/magnet_radius_player_mod.png")


func equip(player : Player):
	super(player)
	player.modify_magnet_radius_multiplier(magnet_radius_multiplier)


func remove_mod():
	player.modify_magnet_radius_multiplier(-1 * magnet_radius_multiplier)
