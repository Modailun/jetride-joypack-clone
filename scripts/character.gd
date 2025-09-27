extends RigidBody2D

# Force appliquée par le jetpack (ajustable)
var jetpack_force : float = 150000.0
# Vitesse maximale vers le haut (pour éviter une accélération infinie)
var max_upward_speed : float = 800.0
var air_resistance : float = 0.98  # Facteur de ralentissement

@onready var truster_particle: GPUParticles2D = $TrusterParticle
@onready var smoke_particle: GPUParticles2D = $SmokeParticle
@onready var truster_cpuparticules: CPUParticles2D = $TrusterCPUParticules

func _ready() -> void:
	if OS.has_feature("web"):
		truster_particle.visible = false
		smoke_particle.visible = false
		truster_cpuparticules.visible = true
	else:
		truster_particle.visible = true
		smoke_particle.visible = true
		truster_cpuparticules.visible = false

func _physics_process(delta: float) -> void:
	truster_particle.emitting = false
	truster_cpuparticules.emitting = false
	smoke_particle.emitting = false
	# Si le bouton "Jump" est maintenu et que la vitesse vers le haut n'est pas trop élevée
	if Input.is_action_pressed("Jump") and linear_velocity.y > -max_upward_speed:
		# Applique une force vers le haut
		apply_central_impulse(Vector2(0, -jetpack_force * delta))
		truster_particle.emitting = true
		truster_cpuparticules.emitting = true
		smoke_particle.emitting = true
	else:
		# Ralentit progressivement la vitesse verticale
		linear_velocity.y *= air_resistance

