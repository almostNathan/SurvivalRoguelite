extends BaseBullet
class_name LaserBullet

@onready var fadeout_timer = $FadeoutTimer


func _physics_process(_delta):
	position = player.position
	

func _ready():
	var bodies_in_area = get_overlapping_bodies()
	for body in bodies_in_area:
		if body.has_method("hit") && body.is_in_group("enemy"):
			weapon.emit_signal("on_hit", body, self)

func _on_fadeout_timer_timeout():
	queue_free()
