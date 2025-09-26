extends Area2D

# Vitesse de déplacement (ajustable)
var speed : float = 100.0

signal obstacle_hit(player)

func _physics_process(delta: float) -> void:
	# Déplace l'obstacle vers la gauche
	position.x -= speed * delta
	# Supprime l'obstacle s'il sort de l'écran (optionnel)
	if position.x < -10:  # Ajuste cette valeur selon la taille de ton jeu
		#print("Obstacle out of screen, removing.")
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	print("Obstacle hit: ", body.name)
	body.queue_free()
	# Decrease life
	#get_parent().lose_life()
	emit_signal("obstacle_hit")
