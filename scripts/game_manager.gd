extends Node

# Score actuel du joueur
var score: int = 0
# Nombre de vies restantes
var lives: int = 1
# Multiplicateur de score (augmente toutes les 10 secondes détruites)
var mul: int = 1
var obstacle_scene: PackedScene = preload("res://scenes/obstacle.tscn")
# Position de départ (à droite de l'écran)
var start_position : Vector2 = Vector2(650, 150)  # Ajuste selon ton jeu

@onready var score_label: Label = $ScoreLabel
#@onready var lives_label: Label = $LivesLabel
@onready var best_score_label: Label = $BestScoreLabel

func _ready() -> void:
	# Initialise les labels avec les valeurs de départ
	score_label.text = "Score: " + str(score)
	#lives_label.text = "Lives: " + str(lives)
	best_score_label.text = "Best score: " + str(get_high_score())
	# Crée un Timer pour générer les obstacles

func _on_timer_timeout() -> void:
	# Instancie un nouvel obstacle
	var obstacle = obstacle_scene.instantiate()
	# Positionne l'obstacle à droite de l'écran
	obstacle.position = start_position
	# Ajoute l'obstacle à la scène
	add_child(obstacle)
	obstacle.connect("obstacle_hit", _on_obstacle_hit)
	# Optionnel : aléatoire pour la position verticale
	obstacle.position.y = randf_range(24, 336)

func _on_score_timer_timeout() -> void:
	add_point(10)

func _on_obstacle_hit() -> void:
	# Gère la collision avec l'obstacle
	lose_life()  # Retire une vie au joueur

# Ajoute des points au score
func add_point(points: int) -> void:
    # Ajoute les points au score
	score += points
    # Met à jour l'affichage du score
	score_label.text = "Score: " + str(score)
	best_score_label.text = "Best score: " + str(max(score, get_high_score()))

# Retire une vie au joueur
func lose_life() -> void:
	if lives > 1:
		lives -= 1  # Retire une vie
		mul = 1  # Réinitialise le multiplicateur
		# Met à jour l'affichage du score et des vies
		score_label.text = "Score: " + str(score)
		#lives_label.text = "Lives: " + str(lives)
	else:
		# Si c'était la dernière vie, le joueur perd
		game_over()

# Gère la fin de partie (victoire ou défaite)
func game_over() -> void:
	# Enregistre le dernier score dans le gestionnaire de scènes
	ScenesManager.latest_score = score
	save_high_score()  # Sauvegarde le meilleur score
	ScenesManager.high_score = get_high_score()  # Récupère le meilleur score

	# Réinitialise les variables pour une nouvelle partie
	score = 0
	lives = 3
	mul = 1

	#print("Game Over")  # Affiche "Game Over" dans la console
	# Charge l'écran de fin de partie (défaite)
	ScenesManager.change_scene(ScenesManager.Scenes["END_SCREEN_LOSE"])

func save_high_score() -> void:
	var config = ConfigFile.new()
	config.load("user://savegame.cfg")
	if not config.has_section("HighScores"):
		config.set_value("HighScores", "score", score)
	else:
		var high_score = config.get_value("HighScores", "score", 0)
		if score > high_score:
			config.set_value("HighScores", "score", score)
	config.save("user://savegame.cfg")

func get_high_score() -> int:
	var config = ConfigFile.new()
	var error = config.load("user://savegame.cfg")
	if error == OK:
		if config.has_section("HighScores"):
			return config.get_value("HighScores", "score", 0)
	return 0
