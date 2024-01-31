extends BaseDebuff
class_name KnockbackDebuff

var knockback_velocity : Vector2
var knockback_acceleration = 10000

func _ready():
	super()
	parent.moving.connect(_move_character)
	define_knockback_velocity()
	
func _move_character(velocity, delta):
	parent.velocity = knockback_velocity * delta
	#parent.velocity = Vector2.ZERO

func define_knockback_velocity():
	var player : Player = get_tree().get_root().get_child(0).find_child("Player")
	var player_position = player.position
	var knockback_vector = player_position.direction_to(parent.position)
	knockback_velocity = knockback_vector * knockback_acceleration
	
	


func _on_timer_timeout():
	queue_free()
