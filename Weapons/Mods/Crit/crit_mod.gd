extends BaseMod
class_name CritMod

var crit_chance = .5

func set_base_data():
	tooltip_text = "Crit"
	mod_name = "Crit"
	icon = preload("res://Art/Drops/crit_mod.png")

func equip(new_weapon):
	super(new_weapon)
	var weapon_child_nodes = weapon.get_children()
	for node in weapon_child_nodes:
		if node is BaseMod:
			node.mod_hitting.connect(_modify_hit)

func _modify_hit(mod):
	if randf() <= crit_chance:
		if mod is DamageMod:
			_apply_damage_crit(mod)
	
func _apply_damage_crit(mod):
	mod.damage_value *= 2

func remove_mod():
	super()
	#TODO need to figure out how to hand crit before handling removal

