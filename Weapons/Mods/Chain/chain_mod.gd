extends BaseMod
class_name ChainMod

var chain_count = 3
var chain_range = 200
var damage_coefficient = .3
var chain_scene = preload("res://GeneralMods/Effects/Chain/chain_effect.tscn")

func _init():
	tooltip_text = "Chain Mod"
	icon = preload("res://Art/Drops/chain-lightning.png")
	

func equip(new_weapon):
	super(new_weapon)
	refresh()
	
func remove_mod():
	super()

func refresh():
	pass
	
func _on_hit(body, _weapon):
	#TODO Create a 2DArea that picks up all enemies in chain range. Then get nearest enemy, chain to them and repeat. 
	#var target_area =  Area2D.new()
	#var target_collision_shape = CollisionShape2D.new()
	#var target_circle_shape = CircleShape2D.new()
	#target_area.add_child(target_collision_shape)
	#target_collision_shape.shape = target_circle_shape
	#target_circle_shape.radius = chain_range
	
	var current_target = body
	for i in range(chain_count):
		var next_target = body.get_nearest_enemies(1, chain_range)
		
		
		
	
