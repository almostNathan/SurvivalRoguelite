extends TextureRect
var opacity_tween : Tween = null

func show_damage():
	self.visible = true
	modulate.a = 0.0
	await tween_opacity(1.0).finished
	modulate.a = 1.0
	await tween_opacity(0.0).finished
	self.visible = false


func tween_opacity(to: float):
	if opacity_tween: opacity_tween.kill()
	opacity_tween = create_tween()
	opacity_tween.tween_property(self, 'modulate:a', to, .1)
	return opacity_tween
