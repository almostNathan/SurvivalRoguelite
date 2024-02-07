extends BaseBullet
class_name AuraBullet

func _physics_process(delta):
	weapon_image.rotate(PI/16)
	position = player.position


func _on_body_entered(body):
	pass
	



func _on_damage_timer_timeout():
	var enemies_on_screen = get_tree().get_nodes_in_group("enemy")
	var bodies_in_area = get_overlapping_bodies()
	for body in bodies_in_area:
		if body in enemies_on_screen:
			if body.has_method("hit") && body.is_in_group("enemy"):
				enemies_hit += 1
				weapon.emit_signal("on_hit", body, self)

