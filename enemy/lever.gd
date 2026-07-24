extends CharacterBody2D

var on : bool = true

var tween_l: Tween
var tween_r: Tween
@export var move_duration: float = 0.5

func damage(value):
	on = !on
	print(on)
	if(on):
		$AnimatedSprite2D.play("on")
		_move_to($door/left, Vector2(0, -32))
		_move_to_r($door/right, Vector2(0, 32))
	else:
		$AnimatedSprite2D.play("default")
		_move_to($door/left, Vector2(0, 32))
		_move_to_r($door/right, Vector2(0, -32))
		
func _move_to(target, target_pos: Vector2) -> void:
	# Kill running tween if activated rapidly
	if tween_l and tween_l.is_running():
		tween_l.kill()
		
	tween_l = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	# Tweening position on AnimatableBody2D updates collisions automatically
	tween_l.tween_property(target, "global_position", target.global_position + target_pos, move_duration)

func _move_to_r(target, target_pos: Vector2) -> void:
	# Kill running tween if activated rapidly
	if tween_r and tween_r.is_running():
		tween_r.kill()
		
	tween_r = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	# Tweening position on AnimatableBody2D updates collisions automatically
	tween_r.tween_property(target, "global_position", target.global_position + target_pos, move_duration)
