extends Area2D

# Vitesse de déplacement (ajustable)
var speed : float = 100.0

signal obstacle_hit(player)
@onready var timer: Timer = $Timer
@onready var cpuparticles_2d: CPUParticles2D = $CPUParticles2D

func _physics_process(delta: float) -> void:
	# Déplace l'obstacle vers la gauche
	position.x -= speed * delta
	# Supprime l'obstacle s'il sort de l'écran (optionnel)
	if position.x < -10:  # Ajuste cette valeur selon la taille de ton jeu
		#print("Obstacle out of screen, removing.")
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	#print("Obstacle hit: ", body.name)
	if body.name == "Character":
		cpuparticles_2d.emitting = true
		# Slow motion effect
		Engine.time_scale = 0.5
		# Disable collision shape for the player
		body.queue_free()
		# Start timer to reset time scale, re-enable input and decrease life
		timer.start()


func _on_timer_timeout() -> void:
	# Reset time scale
	Engine.time_scale = 1
	# Decrease life
	emit_signal("obstacle_hit")
