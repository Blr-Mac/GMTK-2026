extends CharacterBody2D

const SPEED = 300.0
var local_mouse_pos: Vector2

@export var projectile_scene: PackedScene
@onready var muzzle: Marker2D = $Muzzle

func _physics_process(delta: float) -> void:
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
	var projectile = projectile_scene.instantiate() as RigidBody2D
	
	get_tree().current_scene.add_child(projectile)

	projectile.global_position = global_position
	projectile.global_rotation = global_rotation
	
	projectile.global_position += launch_angle * Vector2(30,30)
	projectile.launch(launch_angle)
	
func pickup_blood(value : int):
	print("blood: ", value)
