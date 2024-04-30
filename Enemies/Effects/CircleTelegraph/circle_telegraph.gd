extends Area2D
class_name CircleTelegraph

signal lifespan_timeout(this)

@onready var telegraph_sprite = $TelegraphSprite
@onready var lifespan_timer = $LifespanTimer

var alpha_min = .3
var alpha_max = .7
var alpha_direction = 1

func _ready():
	lifespan_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	telegraph_sprite.modulate.a += delta  * alpha_direction *  20


func _on_alpha_timer_timeout():
	alpha_direction *= -1

func set_lifespan(new_lifespan):
	lifespan_timer.wait_time = new_lifespan


func _on_lifespan_timer_timeout():
	lifespan_timeout.emit(self)
	queue_free()
