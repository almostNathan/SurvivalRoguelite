extends TextureRect
class_name LootArrow

var target


func _physics_process(delta):
	if target:
		#self.rotation = (target.global_position - self.global_position).angle()
		self.rotation = self.global_position.angle_to_point(target.global_position)

		

func set_target(new_target):
	target = new_target

