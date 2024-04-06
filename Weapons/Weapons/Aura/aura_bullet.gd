extends BaseBullet
class_name AuraBullet

var hit_count = 1

func _physics_process(_delta):
	weapon_image.rotate(PI/16)
	position = player.position

func _on_body_entered(_body):
	pass

func _on_damage_timer_timeout():
	var bodies_in_area = get_overlapping_bodies()
	for i in range(hit_count):
		var body = bodies_in_area.pick_random()
		if body.has_method("hit") && body.is_in_group("enemy"):
			weapon.emit_signal("on_hit", body, self)
			bodies_in_area.remove_at(bodies_in_area.find(body))

