extends RigidBody2D

# Force appliquée par le jetpack (ajustable)
var jetpack_force : float = 4000.0
# Vitesse maximale vers le haut (pour éviter une accélération infinie)
var max_upward_speed : float = 800.0
var air_resistance : float = 0.95  # Facteur de ralentissement

func _physics_process(delta: float) -> void:
	# Si le bouton "Jump" est maintenu et que la vitesse vers le haut n'est pas trop élevée
	if Input.is_action_pressed("Jump") and linear_velocity.y > -max_upward_speed:
		# Applique une force vers le haut
		apply_central_impulse(Vector2(0, -jetpack_force * delta))
	else:
		# Ralentit progressivement la vitesse verticale
		linear_velocity.y *= air_resistance

