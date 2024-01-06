extends BulletMod
class_name DamageMod

@export var damage_value : float = 10

func _ready():
	super()
	if parent is BaseBullet:
		parent.on_hit.connect(_on_hit)


func _on_shooting_weapon(bullet):
	super(bullet)
	bullet.on_hit.connect(_on_hit)


func _on_hit(body):
	print("damage mod on hit")
	body.hit(self)

func damage_multiplier(mult_value):
	damage_value *= mult_value

func damage_add(add_value):
	damage_value += add_value
