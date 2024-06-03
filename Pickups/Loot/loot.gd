extends Pickup
class_name Loot

var lootable = true
var loot_scene_list = AllModList.mod_scene_list.duplicate()

func _on_body_entered(body):
	if lootable && body is Player:
		lootable = false
		$AnimatedSprite2D.play("open_chest")
		
		Hud.load_loot_menu(loot_scene_list)

func set_loot_scene_list(new_loot_scene_list):
	loot_scene_list = new_loot_scene_list

func _on_animated_sprite_2d_animation_finished():
	queue_free()
