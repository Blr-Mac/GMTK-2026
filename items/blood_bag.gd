extends Area2D

@export var value : int = 5 

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") or body.has_method("add_item"):
		if body.has_method("pickup_blood"):
			body.pickup_blood(value)
	
		queue_free()
