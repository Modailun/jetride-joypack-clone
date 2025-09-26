extends MarginContainer


func _on_button_pressed() -> void:
	delete_high_score()


func delete_high_score() -> void:
	var config = ConfigFile.new()
	var error = config.load("user://savegame.cfg")
	if error == OK:
		if config.has_section("HighScores"):
			config.erase_section("HighScores")
			config.save("user://savegame.cfg")
			print("High score deleted.")
		else:
			print("No high score to delete.")
	else:
		print("Failed to load save file.")