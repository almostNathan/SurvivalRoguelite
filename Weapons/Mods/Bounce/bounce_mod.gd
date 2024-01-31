extends BulletMod
class_name BounceMod

var bounce_modifier = 1

func _init():
	tooltip_text = "Bounce"
	icon = preload("res://Art/Drops/bounce_mod.png")

func _ready():
	super()
	parent.on_hit.connect(_on_hit)
	parent.bounce_value += bounce_modifier
	

func _on_hit(_body, bullet):
	if bullet.enemies_bounced < parent.bounce_value && bullet.delete_bullet == true:
		bullet.delete_bullet = false
		bullet.enemies_bounced += 1
		bullet.modify_movement_direction(PI)

func rank_up():
	bounce_modifier += 1
	if parent != null:
		parent.bounce_value += 1
