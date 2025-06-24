extends BaseBullet
class_name AuraBullet


var hit_count = 1

func _physics_process(_delta):
	weapon_image.rotate(PI/16)
	position = player.position
	var modulation = lifespan_timer.time_left / lifespan_timer.wait_time
	self.modulate = Color(1,1,1,modulation)


#func _ready():
	#var bodies_in_area = await call_deferred("get_overlapping_bodies")
	#if len(bodies_in_area) == 0:
		#pass
	#else:
		#for i in range(hit_count):
			#var body = bodies_in_area.pick_random()
			#if body.has_method("hit") && body.is_in_group("enemy"):
				#weapon.emit_signal("on_hit", body, self)
				#bodies_in_area.remove_at(bodies_in_area.find(body))

func _on_body_entered(body):
	if body.has_method("hit") && body.is_in_group("enemy") and weapon.projectile_count > enemies_hit:
		enemies_hit += 1
		weapon.emit_signal("on_hit", body, self)
		if (delete_bullet):
			queue_free()
