extends CanvasLayer


func _on_texture_button_pressed() -> void:
	#print("Main Menu")
	ScenesManager.change_scene(ScenesManager.Scenes["MAIN_MENU"])
