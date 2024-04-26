extends BaseMod
class_name CurveClockwiseMod

var rotation_in_radians = .05

func equip(weapon):
	super(weapon)
	weapon.setting_movement_direction.connect(_change_movement_direction)

func _change_movement_direction(bullet : BaseBullet):
	bullet.modify_movement_direction(rotation_in_radians)

func remove_mod():
	super()
	weapon.setting_movement_direction.disconnect(_change_movement_direction)

