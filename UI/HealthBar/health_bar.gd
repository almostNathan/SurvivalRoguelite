extends ProgressBar

func _ready():
	var entity = get_parent()
	max_value = entity.max_health
	value = entity.max_health
	entity.set_max_health.connect(_on_base_enemy_set_max_health)
	entity.health_change.connect(_on_base_enemy_health_change)

func _on_base_enemy_health_change(cur_health):
	value = cur_health

func _on_base_enemy_set_max_health(new_max_hp):
	print("healthbar ", new_max_hp)
	max_value = new_max_hp
