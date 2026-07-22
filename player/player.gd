extends CharacterBody2D

const SPEED = 300.0
var local_mouse_pos: Vector2

@export var projectile_scene: PackedScene
@onready var muzzle: Marker2D = $Muzzle

func _physics_process(delta: float) -> void:
	# Get 2D input vector (combines left/right/up/down)
	var input_vector := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if input_vector != Vector2.ZERO:
		velocity = input_vector * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
	
	if Input.is_action_just_pressed("shoot"):
		local_mouse_pos = get_local_mouse_position()
		shoot(local_mouse_pos.normalized())
		
	move_and_slide()


func shoot(launch_angle : Vector2) -> void:
	if not projectile_scene:
		return
		
	# 1. Instance the projectile
	var projectile = projectile_scene.instantiate() as RigidBody2D
	
	# 2. Add it to the main world scene (NOT as a child of the player)
	# This ensures it stays behind when the player moves
	get_tree().current_scene.add_child(projectile)
	
	# 3. Set its starting position and rotation
	projectile.global_position = global_position
	projectile.global_rotation = global_rotation
	
	# 4. Calculate direction (e.g., facing direction of the muzzle)
	#var launch_direction = Vector2.RIGHT.rotated(muzzle.global_rotation)
	projectile.global_position += launch_angle * Vector2(30,30)
	# 5. Apply the physical impulse
	projectile.launch(launch_angle)
