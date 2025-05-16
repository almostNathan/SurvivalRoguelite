extends Node2D
class_name HubScene

func _ready():
	Hud.hide_for_hub()
	Globals.load_game()


func _on_hub_exit_change_scene(new_scene_path):
	Globals.player_data["mod_inventory"] = $Player.mod_inventory
	get_tree().change_scene_to_file(new_scene_path)
	
