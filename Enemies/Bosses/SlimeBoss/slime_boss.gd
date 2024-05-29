extends BaseEnemy
class_name SlimeBoss

var telegraph_zone_scene = preload("res://Enemies/Effects/CircleTelegraph/circle_telegraph.tscn")

var telegraph_zones = []

@onready var attack_timer = $AttackTimer
@onready var telegraph_timer = $TelegraphTimer
@onready var lifespan_timer = $LifespanTimer

var attack_rate = 2
var number_of_attacks = 3
var telegraph_window = .75
var attack_zone_size = 100
var attack_damage = 20

var slime_boss_attack_scene = preload("res://Enemies/Bosses/SlimeBoss/slime_boss_attack.tscn")

func _ready():
	super()
	wait_timer.start()
	telegraph_timer.wait_time = telegraph_window
	attack_timer.wait_time = attack_rate
	var loot_mod = preload("res://Enemies/Mods/DropLoot/drop_loot_mod.tscn").instantiate()
	add_child(loot_mod)

func move(delta):
	if move_timer.is_stopped():
		sprite.animation = "idle"
		velocity = Vector2.ZERO
	else:
		var direction = Vector2.UP.rotated(movement_direction)
		velocity += direction * acceleration * delta
		sprite.animation = "moving"

func _on_attack_timer_timeout():
	var player_position = Globals.player.position
	for attack_number in range(number_of_attacks):
		
		var new_telegraph_zone : CircleTelegraph = telegraph_zone_scene.instantiate()
		add_sibling(new_telegraph_zone)
		var size_scaling_ratio = attack_zone_size/new_telegraph_zone.width
		new_telegraph_zone.scale = Vector2(size_scaling_ratio,size_scaling_ratio)
		new_telegraph_zone.set_lifespan(telegraph_window)
		new_telegraph_zone.position = player_position + Vector2(randf_range(attack_zone_size * -1, attack_zone_size), randf_range(attack_zone_size * -1, attack_zone_size))
		telegraph_zones.append(new_telegraph_zone)
		telegraph_timer.start()
		new_telegraph_zone.lifespan_timeout.connect(_on_telegraph_timer_timeout)

func _on_telegraph_timer_timeout(telegraph_zone):
	var new_slime_boss_attack = slime_boss_attack_scene.instantiate()
	new_slime_boss_attack.base_damage = attack_damage
	add_sibling(new_slime_boss_attack)
	new_slime_boss_attack.position = telegraph_zone.position
