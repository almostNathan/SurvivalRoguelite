extends Area2D
class_name LevelPortal

signal next_level()

@onready var sprite : AnimatedSprite2D = $Sprite

var active = false

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.animation='spawn'
	sprite.play()
	Globals.player.create_portal_arrow(self)

func _on_sprite_animation_finished():
	if sprite.animation == 'spawn':
		sprite.animation = 'idle'
		sprite.play()
	active = true

func _on_body_entered(body):
	if body == Globals.player:
		body.delete_portal_arrow(self)
		emit_signal('next_level')
	call_deferred('queue_free')
