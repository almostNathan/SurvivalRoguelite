extends BaseMod
class_name ChainMod

var chain_count = 3
var chain_range = 200
var damage_coefficient = .5
var damage_value : float

var chain_scene_packed = preload("res://Weapons/Effects/ChainEffect/chain_effect.tscn")

func set_base_data():
	tooltip_text = "Chain Mod"
	mod_name = "Chain"
	icon = preload("res://Art/Drops/chain-lightning.png")
	damage_number_color = Color(3, 236, 252, 1)

func equip(new_weapon):
	super(new_weapon)
	weapon.on_hit.connect(_on_hit)
	
	refresh()
	
func remove_mod():
	super()
	weapon.on_hit.disconnect(_on_hit)

func refresh():
	if weapon != null:
		damage_value = weapon.current_damage * damage_coefficient * current_rank
	
func _on_hit(body, bullet):
	if weapon != null:
		var chain_enemies = find_chained_enemies(body)
		for enemy in chain_enemies:
			_apply_damage_numbers(enemy, snapped(damage_value, 1))
			enemy.lose_life({"weapon" : weapon, "damage" : damage_value})
			weapon.proc_hit(enemy, bullet, .5)
		
	#var chain_enemies = []
	#
	#var current_target = body
	#for i in range(chain_count):
		#var area = Area2D.new()
		#var collision_shape = CollisionShape2D.new()
		#var circle_shape = CircleShape2D.new()
		#collision_shape.shape = circle_shape
		#circle_shape.radius = chain_range
		#body.add_sibling(area)
		#area.position = body.position
		#
		#var enemies_in_hitbox = area.get_overlapping_bodies()
		##var enemies_in_hitbox = Globals.create_hitbox(current_target, circle_shape)
		#print(enemies_in_hitbox)
#
		#for enemy in enemies_in_hitbox:
			#print(enemy in chain_enemies, " ", enemy not in chain_enemies)
			#if enemy.is_in_group("enemy") && enemy not in chain_enemies:
				#current_target = enemy
				#chain_enemies.append(current_target)
				#break

		


func find_chained_enemies(origin: CharacterBody2D):
	var chain_enemies: Array[CharacterBody2D] = []
	var searched_entities: Array[CharacterBody2D] = [origin]

	while true:
		# Find the closest enemy to the last entity in the chain
		var closest_enemy: CharacterBody2D = null
		var closest_distance: float = INF
		for enemy in origin.get_tree().get_nodes_in_group("enemy"):
			if  not searched_entities.has(enemy):
				
				var distance = searched_entities[-1].global_position.distance_to(enemy.global_position)
				if distance < closest_distance && distance < chain_range:
					closest_enemy = enemy
					closest_distance = distance
		
		# If no more enemies found, exit the loop
		if len(chain_enemies) > chain_count or closest_enemy == null:
			break
		
		# Add the new enemy to the chain and the list of searched entities
		chain_enemies.append(closest_enemy)
		searched_entities.append(closest_enemy)
		for i in range(len(searched_entities)-1):
			var chain_scene = chain_scene_packed.instantiate()
			origin.add_sibling(chain_scene)
			chain_scene.update_chain_effect(searched_entities[i].position, searched_entities[i+1].position)

	return chain_enemies

