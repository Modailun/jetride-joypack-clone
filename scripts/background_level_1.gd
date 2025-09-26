extends Parallax2D

# Facteur d'augmentation de la vitesse (ajustable)
var speed_increase_factor: float = 1.1

func _on_timer_timeout() -> void:
    # Augmente la vitesse progressivement, sans dépasser max_speed
    self.autoscroll.x *= speed_increase_factor