extends RigidBody2D

@export var speed: float = 800.0
@export var lifetime: float = 5.0 # Despawn timer

func launch(direction: Vector2) -> void:
	var impulse = direction.normalized() * speed
	
	apply_central_impulse(impulse)

func _ready() -> void:
	get_tree().create_timer(lifetime).timeout.connect(queue_free)
