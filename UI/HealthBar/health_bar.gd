extends ProgressBar

func _ready():
	var entity = get_parent()
	max_value = entity.max_health
	value = entity.max_health
	entity.health_change.connect(_on_base_enemy_health_change)

func _on_base_enemy_health_change(cur_health):
	value = cur_health
