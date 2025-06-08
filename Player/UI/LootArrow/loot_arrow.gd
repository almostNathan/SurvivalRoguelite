extends TextureRect
class_name LootArrow

@export var arrow_size = 20
@export var arrow_spacing = 30

var target
var player

func _ready():
	self.size = Vector2(arrow_size, arrow_size)
	self.position = Vector2(arrow_spacing, -arrow_size/2)
	self.pivot_offset = Vector2(-arrow_spacing, arrow_size/2)

func _physics_process(delta):
	if target:
		#self.rotation = (target.global_position - self.global_position).angle()
		self.rotation = player.global_position.angle_to_point(target.global_position)


func set_target(new_player, new_target):
	player = new_player
	target = new_target
	
