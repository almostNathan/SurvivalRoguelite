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

func _modify_hit(mod):
	if randf() <= crit_chance:
		if mod is DamageMod:
			_apply_damage_crit(mod)
	
func _apply_damage_crit(mod):
	mod.damage_value *= 2
