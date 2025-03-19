extends CharacterBody2D
class_name BaseEnemy

signal set_max_health(max_health)
signal on_death()
signal on_physics_process(delta)
signal health_change(cur_health)
signal moving(velocity, delta)

###Enemy stat block
var stats = EnemyStats.get_stats(self)
var max_health : float = stats["max_health"]
var cur_health = max_health
var max_speed : float = stats["max_speed"]
var spawn_value = stats["spawn_value"]
var base_damage = stats["base_damage"]
var exp_value = stats["exp_value"]

@onready var health_bar = $HealthBar
@onready var move_timer = $MoveTimer
@onready var wait_timer = $WaitTimer
@onready var sprite = $AnimatedSprite
@onready var debuff_bar = $DebuffBar

var effect_queue : Array = []
var debuff_array : Array = []
var acceleration = 1500
var friction = 1200.0
var move_distance = 1000.0
@onready var movement_direction : float = 0.0


var elite_scaling_hp_modifier = 5.0
var elite_scaling_damage_modifier = 5.0


func _init():
	set_max_hp(max_health)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.play("idle")
	cur_health = max_health
	sprite.scale = Vector2(2,2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#apply effect of all mods recently applied to enemy
	for mod in effect_queue:
		mod.call_deferred("apply_effect", self)
	effect_queue = []
	
	on_physics_process.emit(delta)
	
	if !sprite.is_playing():
		sprite.play("idle")
	move(delta)
	velocity = velocity.limit_length(max_speed)
	moving.emit(velocity, delta)
	var collision = move_and_slide()

	

func hit(weapon_info : Dictionary):
	if cur_health > 0:
		cur_health -= weapon_info['damage']
		if cur_health <= 0:
			if weapon_info['weapon'] != null:
				weapon_info['weapon'].on_kill.emit(self)
			on_death.emit()
			queue_free()
		else:
			health_change.emit(cur_health)

func lose_life(weapon_info : Dictionary):
	if cur_health > 0:
		cur_health -= weapon_info['damage']
		if cur_health <= 0:
			if weapon_info['weapon'] != null:
				weapon_info['weapon'].on_kill.emit(self)
			on_death.emit()
			queue_free()
		else:
			health_change.emit(cur_health)

	
func move(delta):
	var direction = Vector2.UP.rotated(movement_direction)
	velocity += direction * acceleration * delta
	

func set_movement_direction(direction : float):
	movement_direction = direction

func add_to_mod_queue(mod_to_add):
	effect_queue.append(mod_to_add)

func deal_damage():
	return base_damage

func _on_move_timer_timeout():
	wait_timer.start()

func _on_wait_timer_timeout():
	move_timer.start()

func add_mod(mod_to_add):
	self.add_child(mod_to_add)

func add_debuff(debuff : BaseDebuff):
	debuff_array.append(debuff)
	debuff_bar.update_debuff_bar(debuff_array)
	add_child(debuff)
	debuff.duration_timeout.connect(remove_debuff)

func remove_debuff(debuff):
	debuff_array.remove_at(debuff_array.find(debuff))
	debuff_bar.update_debuff_bar(debuff_array)
	debuff.queue_free()


func make_elite():
	var loot_mod = preload("res://Enemies/Mods/DropLoot/drop_loot_mod.tscn").instantiate()
	add_child(loot_mod)
	scale = Vector2(2,2)
	max_health = max_health * elite_scaling_hp_modifier
	base_damage = base_damage * elite_scaling_damage_modifier
	cur_health = max_health
	set_max_health.emit(max_health)
	health_change.emit(cur_health)

func modify_stats(modifiers):
	max_health = max_health * modifiers.health_modifier
	base_damage = base_damage * modifiers.damage_modifier
	max_speed *= modifiers.speed_modifier
	cur_health = max_health
	set_max_health.emit(max_health)
	health_change.emit(cur_health)

func set_max_hp(new_max_health):
	cur_health += new_max_health - max_health
	if cur_health > new_max_health:
		cur_health = new_max_health
	max_health = new_max_health
	set_max_health.emit(max_health)
	health_change.emit(max_health)
	
func get_nearest_enemies(num_of_enemies, range):
	var nearest_enemies = []
	var distances = []
	var return_array = []
	var enemies = get_tree().get_nodes_in_group("enemy")
	for enemy in enemies:
		if enemy != self:
			var distance_to_enemy = self.position.distance_to(enemy.position)
			if distance_to_enemy < range:
				nearest_enemies.push_front(enemy)
				distances.push_front(distance_to_enemy)
	
	for i in range(num_of_enemies):
		var next_closest_array_position = distances.find(distances.min())
		return_array.push_front(nearest_enemies.pop_at(next_closest_array_position))
		distances.pop_at(next_closest_array_position)
