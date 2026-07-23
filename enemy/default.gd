extends CharacterBody2D

@export var projectile_scene: PackedScene

var shoot_timer : float = 0

func _process(delta: float):
	#print(shoot_timer)
	shoot_timer += delta
	if (shoot_timer > 3):
		var player = get_tree().get_first_node_in_group("player")
		if player:
			var target_position: Vector2 = player.global_position
			shoot(global_position.direction_to(target_position))
		shoot_timer = 0 
		
func shoot(launch_angle : Vector2) -> void:
	if not projectile_scene:
		return
	var projectile = projectile_scene.instantiate() as RigidBody2D
	
	get_tree().current_scene.add_child(projectile)

	projectile.global_position = global_position
	projectile.global_rotation = global_rotation
	
	projectile.global_position += launch_angle * Vector2(20,20)
	projectile.launch(launch_angle)
	
func damage(value: float):
	#print("damage: ", value)
	queue_free()
