extends PanelContainer
class_name GameOverScreen

@onready var score_label = $MarginContainer/VBoxContainer/ScoreLabel

func load_game_over_screen():
	var player_score = Globals.player.exp_mod_man.exp_total
	score_label.text = "You're score is: " + str(player_score)
	get_tree().paused = true
	visible = true

func _on_button_pressed():
	get_tree().paused = false
	visible = false
	Globals.main_scene.reset_game()
