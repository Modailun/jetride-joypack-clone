extends Node2D

# Liste des chemins vers tes scènes
const Scenes := {
	"MAIN_MENU" = "res://scenes/main_menu.tscn",
	#"LEVEL_1" = "res://scenes/level_1.tscn",
	"END_SCREEN_WIN" = "res://scenes/end_screen_win.tscn",
	"END_SCREEN_LOSE" = "res://scenes/end_screen_lose.tscn",
	"SETTINGS" = "res://scenes/settings.tscn",
	"CREDITS" = "res://scenes/credits.tscn"
}

# Scène actuelle
var current_scene : Node = null
var latest_score : int = 0
var high_score : int = 0

func _ready():
	# Charge la scène de départ (ex: menu principal)
	change_scene(Scenes["MAIN_MENU"])

# Fonction pour changer de scène
func change_scene(new_scene_path: String) -> void:
	# Supprime la scène actuelle si elle existe
	if current_scene:
		current_scene.queue_free()

	# Charge la nouvelle scène
	var new_scene = load(new_scene_path).instantiate()
	current_scene = new_scene
	get_tree().current_scene.add_child(new_scene)
