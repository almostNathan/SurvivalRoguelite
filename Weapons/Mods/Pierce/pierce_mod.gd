extends BulletMod
class_name PierceMod

var pierce_modifier = 1
var pierces_used = 0


func _init():
	tooltip_text = "Pierce"
	icon = preload("res://Art/Drops/pierce_mod.png")

func _ready():
	super()
	parent.on_hit.connect(_on_hit)
	parent.pierce_value += pierce_modifier
	

func _on_hit(_body, bullet):
	if bullet is BaseBullet && bullet.enemies_pierced < parent.pierce_value && bullet.delete_bullet == true:
		bullet.delete_bullet = false
		bullet.enemies_pierced += 1
		
func rank_up():
	pierce_modifier += 1
	if parent != null:
		parent.pierce_value += 1



