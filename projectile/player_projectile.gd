extends RigidBody2D

@export var speed: float = 800.0
@export var lifetime: float = 5.0 # Despawn timer
@export var damage: float = 1

func launch(direction: Vector2) -> void:
	var impulse = direction.normalized() * speed
	
	apply_central_impulse(impulse)

func _ready() -> void:
	get_tree().create_timer(lifetime).timeout.connect(queue_free)
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.damage(damage)
		queue_free()
