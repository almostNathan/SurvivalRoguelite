extends BasePlayerMod
class_name WASDPlayerMod

var player_weapons = []
var damage_modifier = 0.0
var damage_modifier_per_weapon_value = .5
var weapons_equipped = 0

func set_base_data():
	mod_name = "WASD"

func equip(player : Player):
	super(player)
	player_weapons = player.weapon_inventory
	weapons_equipped = len(player_weapons)
	damage_modifier = damage_modifier_per_weapon_value * (weapons_equipped - 1)
	player.moving.connect(_toggle_weapons)
	player.equipping_weapon.connect(_new_weapon_equipped)
	for weapon in player_weapons:
		apply_effect_to_weapon(weapon)

#func equip(player : Player):
	#super(player)
	#for weapon in player.weapon_inventory:
		#modified_weapons.append(weapon)
		#apply_effect_to_weapon(weapon)

func refresh():
	for weapon in player_weapons:
		remove_effect_from_weapon(weapon)
	for weapon in player_weapons:
		apply_effect_to_weapon(weapon)

func apply_effect_to_weapon(weapon):
	weapon.modify_damage_mult(damage_modifier)
	
func remove_effect_from_weapon(weapon):
	weapon.modify_damage_mult(-damage_modifier)


func _new_weapon_equipped(new_weapon):
	weapons_equipped += 1
	damage_modifier = damage_modifier_per_weapon_value * (weapons_equipped - 1)
	refresh()

func _toggle_weapons(movement_direction, velocity):
	if len(player_weapons) == 1:
		_one_weapon(movement_direction, velocity)
	if len(player_weapons) == 2:
		_two_weapon(movement_direction, velocity)
	if len(player_weapons) == 3:
		_three_weapon(movement_direction, velocity)
	if len(player_weapons) == 4:
		_four_weapon(movement_direction, velocity)


func _one_weapon(movement_direction, velocity):
	player_weapons[0].toggle(true)

func _two_weapon(movement_direction, velocity):
	#Split into UP  and  DOWN
	if movement_direction.y < 0:
		player_weapons[0].toggle(true)
		player_weapons[1].toggle(false)
	if movement_direction.y > 0:
		player_weapons[0].toggle(false)
		player_weapons[1].toggle(true)
	elif movement_direction == Vector2(0,0):
		player_weapons[0].toggle(true)
		player_weapons[1].toggle(true)


func _three_weapon(movement_direction, velocity):
	pass
	
func _four_weapon(movement_direction, velocity):
	if movement_direction.y < 0:
		player_weapons[0].toggle(true)
		player_weapons[2].toggle(false)
	if movement_direction.y > 0:
		player_weapons[0].toggle(false)
		player_weapons[2].toggle(true)
	#if movement_direction.y == 0:
		#player_weapons[0].toggle(true)
		#player_weapons[2].toggle(true)
	if movement_direction.x < 0:
		player_weapons[1].toggle(true)
		player_weapons[3].toggle(false)
	if movement_direction.x > 0:
		player_weapons[1].toggle(false)
		player_weapons[3].toggle(true)
	#if movement_direction.x == 0:
		#player_weapons[1].toggle(true)
		#player_weapons[3].toggle(true)
	if movement_direction == Vector2(0,0):
		for weapon in player_weapons:
			weapon.toggle(true)
