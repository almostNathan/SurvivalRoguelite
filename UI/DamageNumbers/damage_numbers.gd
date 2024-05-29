extends Control
class_name DamageNumbers

@onready var animation_player = $AnimationPlayer
@onready var label_container = $LabelContainer
@onready var label = $LabelContainer/Label

func set_values_and_animate(value, start_pos, height, spread):
	label.text = str(value)
	animation_player.play("damage_number_animation")

	var tween = get_tree().create_tween()
	var end_pos = Vector2(randf_range(-spread, spread), -height) + start_pos
	var tween_length = animation_player.get_animation("damage_number_animation").length
	
	tween.tween_property(label_container, "position", end_pos, tween_length).from(start_pos)


func remove():
	animation_player.stop()
	if is_inside_tree():
		get_parent().remove_child(self)

func set_color(new_color : Color):
	var new_label_settings = label.label_settings.duplicate()
	new_label_settings.font_color = new_color
	label.label_settings = new_label_settings
	
func set_style(style_settings : Dictionary):
	var new_label_settings = label.label_settings.duplicate()

	if style_settings['color'] != null:
		new_label_settings.font_color = style_settings['color']

	label.label_settings = new_label_settings

