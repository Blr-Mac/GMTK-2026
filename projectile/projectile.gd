extends RigidBody2D

@export var speed: float = 800.0
@export var lifetime: float = 5.0 # Despawn timer

# Custom setup function called by the shooter script
func launch(direction: Vector2) -> void:
	# Convert direction into velocity impulse
	var impulse = direction.normalized() * speed
	
	# apply_central_impulse gives an instantaneous physical "kick"
	apply_central_impulse(impulse)

func _ready() -> void:
	# Automatically destroy projectile after X seconds to clean up memory
	get_tree().create_timer(lifetime).timeout.connect(queue_free)
