extends BaseBullet
class_name MagicBookBullet

var move_speed = 600
var target_location : Vector2
var damage_zone = preload("res://GeneralMods/Effects/MagicBookZone/magic_book_zone.tscn")


func _physics_process(delta):
	position = position.move_toward(target_location, move_speed * delta)
	if position == target_location:
		var new_damage_zone = damage_zone.instantiate()
		new_damage_zone.global_position = position
		new_damage_zone.weapon = weapon
		weapon.player.add_sibling(new_damage_zone)
		queue_free()

func set_aiming_angle(aiming_angle):
	self.rotate(aiming_angle)