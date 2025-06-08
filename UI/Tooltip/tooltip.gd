extends PanelContainer
class_name Tooltip

const OFFSET: Vector2 = Vector2.ONE * 20
var opacity_tween: Tween = null

# Called when the node enters the scene tree for the first time.
func _input(event: InputEvent):
	if visible and event is InputEventMouseMotion:
		global_position = get_global_mouse_position() + OFFSET

func toggle(on : bool):
	if on:
		self.visible = true
		modulate.a = 0.0
		tween_opacity(1.0)
	else:
		modulate.a = 1.0
		var new_tween = tween_opacity(0.0)
		if new_tween != null:
			await new_tween.finished
		self.visible = false

func tween_opacity(to: float):
	if opacity_tween: opacity_tween.kill()
	opacity_tween = create_tween()
	if opacity_tween != null:
		opacity_tween.tween_property(self, 'modulate:a', to, .1)
		return opacity_tween
