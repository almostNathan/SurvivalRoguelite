extends BaseEnemy
class_name Goblin

func _ready():
	super()
	$AnimatedSprite.play("moving")

func _init():
	super()
	enemy_name = "goblin"

func move(delta):
	var direction = Vector2.UP.rotated(movement_direction)
	var distance_to_player = self.position.distance_to(Globals.player.position)
	direction = direction.rotated(PI/(4 * clamp(distance_to_player-200,1,200)))
	velocity += direction * acceleration * delta
	
#func move(delta):
	#super(delta)
	##var clamped_distance_to_player = clamp((self.position.distance_to(Globals.player.position) - 300), 2, 500)
	##if self.position.distance_to(Globals.player.position) < 200:
	#var distance_to_player = self.position.distance_to(Globals.player.position)
	#velocity = velocity.rotated(PI/(4 * clamp(distance_to_player-200,1,100)))

