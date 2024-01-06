extends BaseMod
class_name BulletMod

func _ready():
	super()
	if parent is BaseWeapon:
		parent.shooting_weapon.connect(_on_shooting_weapon)

	
func _on_shooting_weapon(bullet:BaseBullet):
	bullet.add_mod(self.duplicate())
