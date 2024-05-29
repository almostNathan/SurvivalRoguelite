extends TextureRect
class_name DebuffIcon

var debuff : BaseDebuff
@onready var debuff_count = $DebuffCount

func set_debuff(new_debuff):
	self.texture = new_debuff.debuff_icon

func set_debuff_count(count):
	debuff_count.text = str(count)
