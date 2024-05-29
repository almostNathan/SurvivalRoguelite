extends GridContainer
class_name DebuffBar

var debuff_icon_scene : PackedScene = preload("res://UI/DebuffBar/DebuffIcon/debuff_icon.tscn")
var debuff_array : Array = []

func _physics_process(delta):
	if len(debuff_array) > 0:
		update_debuff_bar(debuff_array) 
		

func update_debuff_bar(debuff_array):
	debuff_array = debuff_array
	var debuff_array_reference = debuff_array.duplicate()
	clear_debuff_bar()
	

	for debuff in debuff_array_reference:
		var i = 0
		var debuff_count = 1
		for j in range(len(debuff_array_reference) -1, i, -1):
			if i != j:
				if debuff_array_reference[j].is_class(debuff_array_reference[i].get_class()):
					debuff_count += 1
					debuff_array_reference.remove_at(j)
		
		var new_debuff_icon = debuff_icon_scene.instantiate()
		add_child(new_debuff_icon)

		new_debuff_icon.set_debuff(debuff_array_reference[i])
		new_debuff_icon.set_debuff_count(debuff_count)
		i += 1
		#TODO build debuff icon class

func clear_debuff_bar():
	for debuff_icon in get_children():
		debuff_icon.queue_free()

