extends CharacterBody2D

var on : bool = true

func damage(value):
	on = !on
	print(on)
	if(on):
		$AnimatedSprite2D.play("on")
	else:
		$AnimatedSprite2D.play("default")
