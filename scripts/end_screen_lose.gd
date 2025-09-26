extends MarginContainer

@onready var score_lose_label: Label = $MarginContainer/HBoxContainer/VBoxContainer/ScoreLoseLabel
@onready var best_score_lose_label: Label = $MarginContainer/HBoxContainer/VBoxContainer/BestScoreLoseLabel

func _ready() -> void:
	score_lose_label.text = "Your Score: " + str(ScenesManager.latest_score)
	best_score_lose_label.text = "Best Score: " + str(ScenesManager.high_score)

func _on_button_pressed() -> void:
	ScenesManager.change_scene(ScenesManager.Scenes["LEVEL_1"])
