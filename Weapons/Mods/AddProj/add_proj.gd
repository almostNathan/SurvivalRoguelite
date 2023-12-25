extends BaseMod

func _ready():
	super()
	weapon.shooting_weapon.connect(_shooting_weapon)
	
	
func _shooting_weapon():
	var projectile_mods = weapon.find_children("AddProj")
	

	
