extends BaseMod
class_name CritMod

var crit_chance = .5

func _init():
	tooltip_text = "Crit"
	icon = preload("res://Art/Drops/crit_mod.png")

func _ready():
	super()
	var weapon_child_nodes = parent.get_children()
	for node in weapon_child_nodes:
		if node is BaseMod:
			node.mod_hitting.connect(_modify_hit)

func _modify_hit(mod_hitting):
	if randf() <= crit_chance:
		if mod_hitting is DamageMod:
			_apply_damage_crit(mod_hitting)
	
func _apply_damage_crit(mod_hitting):
	mod_hitting.damage_value *= 2
