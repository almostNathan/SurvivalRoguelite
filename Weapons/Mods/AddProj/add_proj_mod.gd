extends BaseMod

func _init():
	tooltip_text = "Split Mod"
	icon = preload("res://Art/Drops/add_proj_mod.png")

func _ready():
	super()
	parent.projectile_count += 1
	
func remove_mod():
	parent.projectile_count -= 1
	queue_free()
	
