extends Control

@onready var cooldown_timer = $CooldownTimer
@onready var cooldown_progress_bar = $WeaponSprite/CooldownProgress
@onready var weapon_sprite = $WeaponSprite

func _process(_delta):
	if cooldown_timer.is_stopped():
		cooldown_progress_bar.value = 1
	else:
		cooldown_progress_bar.value = cooldown_timer.time_left / cooldown_timer.wait_time

func set_timer(new_wait_time: float):
	cooldown_timer.wait_time = new_wait_time

func set_sprite(new_sprite_texture : Texture2D):
	weapon_sprite.texture = new_sprite_texture
