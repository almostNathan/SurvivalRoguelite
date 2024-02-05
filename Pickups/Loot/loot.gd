extends Pickup

var selection_count = 3
var lootable = true

func _on_body_entered(body):
	if lootable && body.has_method("trigger_loot"):
		lootable = false
		$AnimatedSprite2D.play("open_chest")
		var all_mod_scene_list = AllModList.mod_scene_list
		var loot_scene_list = []
		for i in range(selection_count):
			loot_scene_list.append(all_mod_scene_list.pick_random())
		
		body.trigger_loot(loot_scene_list)



func _on_animated_sprite_2d_animation_finished():
	queue_free()
