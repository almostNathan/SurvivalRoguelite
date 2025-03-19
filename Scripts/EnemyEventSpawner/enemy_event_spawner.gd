extends Node2D
class_name EnemyEventSpawner

signal trigger_current_event(event_data)

var next_event_timer

var current_event = ''
var current_event_index = 0

var event_array = ['skeleton_event', 'skeleton_event', 'skeleton_event']
var event_timer_array = [60,60,60]

func _ready():
	var next_event_timer : Timer = $NextEventTimer
	queue_next_event()
	

func queue_next_event():
	current_event = event_array[current_event_index]
	if is_instance_valid(next_event_timer):
		next_event_timer.wait_time = event_timer_array[current_event_index]
		next_event_timer.start()

func skeleton_event():
	var skeleton_count
	for i in range(skeleton_count):
		pass


func _on_next_event_timer_timeout():
	call_deferred('skeleton_event')
	current_event_index += 1
