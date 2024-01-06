extends Control

@onready var cooldown_timer = $CooldownTimer
@onready var cooldown_progress_bar = $CooldownProgress
@onready var weapon_texture = $MarginContainer/WeaponTexture

var weapon_in_slot : BaseWeapon

func _ready():
	var player = get_parent().get_parent()
	player.equip_main_weapon_slot.connect(put_weapon)

func _process(_delta):
	if cooldown_timer.is_stopped():
		cooldown_timer.start()
		cooldown_progress_bar.value = 1
	else:
		cooldown_progress_bar.value = cooldown_timer.time_left / cooldown_timer.wait_time

func put_weapon(weapon : BaseWeapon):
	weapon_in_slot = weapon
	weapon_in_slot.shooting_weapon.connect(start_timer)
	update_weapon_slot()
	
func update_weapon_slot():

	weapon_texture.texture = weapon_in_slot.get_child(1).texture

func set_timer(new_wait_time: float):
	cooldown_timer.wait_time = new_wait_time
	
func start_timer():
	print("starting timer")
	cooldown_timer.start()

func set_sprite(new_sprite_texture : Texture2D):
	pass
	#print(new_sprite_texture)
	#weapon_sprite.texture = new_sprite_texture
