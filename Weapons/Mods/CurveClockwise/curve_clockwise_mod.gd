extends BulletMod
class_name CurveClockwiseMod

var rotation_in_radians = .05

func _ready():
	super()
	parent.setting_movement_direction.connect(_change_movement_direction)

func _change_movement_direction(bullet : BaseBullet):
	bullet.modify_movement_direction(rotation_in_radians)

