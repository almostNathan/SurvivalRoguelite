extends BaseBullet
class_name AuraBullet

@onready var fadeout_timer = $FadeoutTimer
var hit_count = 1

func _physics_process(_delta):
	weapon_image.rotate(PI/16)
	position = player.position
	var modulation = fadeout_timer.time_left / fadeout_timer.wait_time
	self.modulate = Color(1,1,1,modulation)


func _ready():
	var bodies_in_area = get_overlapping_bodies()
	if len(bodies_in_area) == 0:
		pass
	else:
		for i in range(hit_count):
			var body = bodies_in_area.pick_random()
			if body.has_method("hit") && body.is_in_group("enemy"):
				weapon.emit_signal("on_hit", body, self)
				bodies_in_area.remove_at(bodies_in_area.find(body))



func _on_fadeout_timer_timeout():
	queue_free()
