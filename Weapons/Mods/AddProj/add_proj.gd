extends BaseMod

func _ready():
	super()
	parent.shooting_weapon.connect(_shooting_weapon)
	
	
func _shooting_weapon():
	var projectile_mods = parent.find_children("AddProj")
	

	
