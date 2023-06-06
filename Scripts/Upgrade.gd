class_name Upgrade


var damage_mult : float
var size_mult : float
var speed_mult : float
var bounce_cnt : int
var projectile_cnt : int

func set_base_stats():
	damage_mult = 1.0
	speed_mult = 1.0
	size_mult = 1.0
	projectile_cnt = 0
	bounce_cnt = 0
