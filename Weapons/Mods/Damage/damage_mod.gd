extends BaseMod
class_name DamageMod

@export var damage_value : float = 10

func _ready():
	super()
	weapon.on_hit.connect(_on_hit)
	

func _on_hit(body):
	body.hit(self)
