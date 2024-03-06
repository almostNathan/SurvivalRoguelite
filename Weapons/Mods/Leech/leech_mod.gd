extends BaseMod
class_name LeechMod

var leech_per_hit = 1

func _init():
	tooltip_text = "Leech"
	icon = preload("res://Art/Drops/leech_mod.png")

func _ready():
	super()
	parent.on_hit.connect(_on_hit)

func _on_hit(_body, _bullet):
	parent.player.gain_life(leech_per_hit)
