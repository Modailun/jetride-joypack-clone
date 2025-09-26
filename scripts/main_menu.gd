extends Container


func _on_start_game_pressed() -> void:
	#print("Start Game")
	ScenesManager.change_scene(ScenesManager.Scenes["LEVEL_1"])

func _on_options_pressed() -> void:
	ScenesManager.change_scene(ScenesManager.Scenes["SETTINGS"])

func _on_credits_pressed() -> void:
	ScenesManager.change_scene(ScenesManager.Scenes["CREDITS"])

func _on_exit_pressed() -> void:
	get_tree().quit()


