extends Node2D

# Preassigned lightning bolt sprite
@onready var lightning_sprite = $ChainSprite

# The two positions to fit the lightning bolt between
var start_pos: Vector2
var end_pos: Vector2

func _ready():
	pass
	# Load the lightning bolt texture
	#lightning_sprite.texture = preload("res://Art/effect_assets/lightning_bolt_1.png")

func update_chain_effect(new_start: Vector2, new_end: Vector2):
	start_pos = new_start
	end_pos = new_end

	# Calculate the distance and angle between the two positions
	var distance = start_pos.distance_to(end_pos)
	var angle = start_pos.angle_to_point(end_pos)

	# Scale and rotate the lightning sprite to fit the two positions
	lightning_sprite.scale.x = distance / lightning_sprite.texture.get_width()
	lightning_sprite.scale.y = lightning_sprite.scale.y * (distance / lightning_sprite.texture.get_height())
	lightning_sprite.rotation = angle

	# Position the lightning sprite between the two points
	global_position = start_pos.lerp(end_pos,.5)
	#global_rotation = 0

	# Ensure the lightning sprite is at the bottom of the z-index
	#lightning_sprite.z_index = -1


func _on_timer_timeout():
	queue_free()
