extends Camera2D

@export var bounding_rect : ColorRect
@onready var main_weapon_icon = $MainWeaponIcon
@onready var offhand_weapon_icon = $OffhandWeaponIcon
@onready var player = get_parent()




func main_weapon_cooldown():
	main_weapon_icon.cooldown_timer.wait_time = player.main_weapon_timer.wait_time
	main_weapon_icon.cooldown_timer.start()
func offhand_weapon_cooldown():
	offhand_weapon_icon.cooldown_timer.wait_time = player.offhand_weapon_timer.wait_time
	offhand_weapon_icon.cooldown_timer.start()
#
#Functions for equipping new weapons and changing the hud
#
func change_main_weapon(new_weapon):
	main_weapon_icon.set_sprite(new_weapon.get_sprite_texture())
	main_weapon_icon.set_timer(new_weapon.get_cooldown())

func change_offhand_weapon(new_weapon):
	offhand_weapon_icon.set_sprite(new_weapon.get_sprite_texture())
	offhand_weapon_icon.set_timer(new_weapon.get_cooldown())
