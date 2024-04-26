extends Node

var level_0_data = {
	background_color = Color(.31,.6,.4,1),
	enemy_pool = EnemyPool.level_0_enemy_pool,
	enemy_health_modifier = 2.0,
	enemy_damage_modifier = 2.0,
	enemy_speed_modifier = 1.3
}

var level_1_data = {
	background_color = Color(.59,.53,.28,1),
	enemy_pool = EnemyPool.level_1_enemy_pool,
	enemy_health_modifier = 4.0,
	enemy_damage_modifier = 4.0,
	enemy_speed_modifier = 1.6
}


var level_2_data = {
	background_color = Color(.27,.53,.87,1),
	enemy_pool = EnemyPool.level_2_enemy_pool,
	enemy_health_modifier = 6.0,
	enemy_damage_modifier = 6.0,
	enemy_speed_modifier = 2.0
}

var level_data_list = [level_0_data, level_1_data, level_2_data]
