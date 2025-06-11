extends BaseMod
class_name LeechMod

var leech_per_hit = 1

func set_base_data():
	tooltip_text = "Leech"
	mod_name = "Leech"
	icon = preload("res://Art/Drops/leech_mod.png")

func equip(new_weapon):
	super(new_weapon)
	weapon.on_hit.connect(_on_hit)
	refresh()

func _on_hit(_body, _bullet):
	if weapon != null:
		weapon.player.gain_life(leech_per_hit)

func refresh():
	leech_per_hit = current_rank

func remove_mod():
	super()
	weapon.on_hit.disconnect(_on_hit)

