extends ProgressBar



func _on_health_component_health_change(cur_health):
	value = cur_health


func _on_health_component_set_max_hp(new_max_value):
	print("new max health set")
	max_value = new_max_value
