extends Node
var player : CharacterBody2D
var main_scene : MainScene

var player_data : Dictionary = {
	"rollover_mods" : []
}

func save_game():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var save_data = {}
	for node in get_tree().get_nodes_in_group("persist"):
		if node.has_method("create_save_data"):
			var node_data = node.create_save_data()
			save_data[node.save_name] = node_data
	var json_string = JSON.stringify(save_data)
	save_file.store_line(json_string)

func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		print("main load_game file does not exist.")
		return
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		var save_data = json.data
		for node in get_tree().get_nodes_in_group("persist"):
			if node.has_method("load_save_data"):
				node.load_save_data(save_data)
		



var mod_scene_list = [
	preload("res://Weapons/Mods/AddProj/add_proj_mod.tscn"),
	preload("res://Weapons/Mods/Bounce/bounce_mod.tscn"),
	preload("res://Weapons/Mods/Burn/burn_mod.tscn"),
	preload("res://Weapons/Mods/Damage/damage_mod.tscn"),
	preload("res://Weapons/Mods/AttackSpeed/attack_speed_mod.tscn"),
	preload("res://Weapons/Mods/Leech/leech_mod.tscn"),
	preload("res://Weapons/Mods/Pierce/pierce_mod.tscn"),
	preload("res://Weapons/Mods/Poison/poison_mod.tscn"),
	preload("res://Weapons/Mods/Splash/splash_mod.tscn"),
	preload("res://Weapons/Mods/TimeBomb/time_bomb_mod.tscn"),
	preload("res://Weapons/Mods/ExplodeOnDeath/explode_on_death_mod.tscn"),
	preload("res://Weapons/Mods/PoisonCloud/poison_cloud_mod.tscn")
]

var weapon_scene_list = [
	preload("res://Weapons/Weapons/Stick/stick_weapon.tscn"),
	preload("res://Weapons/Weapons/Stone/stone_weapon.tscn"),
	preload("res://Weapons/Weapons/Scythe/scythe_weapon.tscn"),
	preload("res://Weapons/Weapons/MagicBook/magic_book_weapon.tscn"),
	preload("res://Weapons/Weapons/Aura/aura_weapon.tscn"),
	preload("res://Weapons/Weapons/Boomerang/boomerang_weapon.tscn"),
	preload("res://Weapons/Weapons/Turret/turret_weapon.tscn")

]

func create_hitbox(target_body, hitbox_shape) -> Array:
	# Create the Area2D node
	var area = Area2D.new()
	
	# Create and configure the CollisionShape2D
	var collision_shape = CollisionShape2D.new()

	collision_shape.shape = hitbox_shape
	collision_shape.debug_color = Color(1,0,0,.5)
	# Add CollisionShape2D as a child of Area2D
	area.add_child(collision_shape)
	
	# Add the Area2D to the scene temporarily
	target_body.add_sibling(area)
	area.position = target_body.position
	
	# Get all overlapping bodies in the 'enemies' group and store with distances
	var enemies_with_distances = []
	var areas = area.get_overlapping_areas()
	var area_center = area.position

	for entity in areas:
		if entity.is_in_group("enemy"):
			var distance = area_center.distance_to(entity.position)
			enemies_with_distances.append({
				"entity": entity,
				"distance": distance
			})

	# Sort enemies by distance (closest first)
	enemies_with_distances.sort_custom(func(a, b): return a["distance"] < b["distance"])

	# Extract just the entities in sorted order
	var sorted_enemies = []
	for enemy_data in enemies_with_distances:
		sorted_enemies.append(enemy_data["entity"])

	# Clean up the temporary Area2D
	area.queue_free()

	return sorted_enemies
