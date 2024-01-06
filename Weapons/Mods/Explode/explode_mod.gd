extends BulletMod



func _on_shooting_weapon(bullet):
	super(bullet)
	bullet.on_hit.connect(_on_hit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_hit(body):
	var effect = preload("res://Weapons/Effects/explosion.tscn")
	var instance = effect.instantiate()
	get_parent().call_deferred("add_child", instance)
	instance.position = position
	var animation = instance.get_node("Animation")
	animation.play()
