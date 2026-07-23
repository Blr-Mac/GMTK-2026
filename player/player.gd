extends CharacterBody2D

const SPEED = 300.0
var local_mouse_pos: Vector2

@export var projectile_scene: PackedScene
@onready var muzzle: Marker2D = $Muzzle

var timer : float = 0
@export var energy_timer : float = 2

@export var shoot_cooldown : float = 1

const DIR_ANIMATIONS: Array[String] = [
	"up",
	"up_right",
	"right",
	"down_right",
	"down",
	"down_left",
	"left",
	"up_left"
]

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	var input_vector := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	timer += delta
	energy_timer -= delta
	
	if energy_timer <= 0:
		Signals.player_energy.emit(-1)
	
	if input_vector != Vector2.ZERO:
		velocity = input_vector * SPEED
		
		var dir_index := vector_to_direction_8(input_vector)
	
		if dir_index != -1:
			var anim_name: String = DIR_ANIMATIONS[dir_index]
			sprite.play(anim_name)
			#print("Direction Index: ", dir_index, " | Playing: ", anim_name)
		else:
			sprite.stop() # Idle

	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
	
	if Input.is_action_just_pressed("shoot") and timer > shoot_cooldown:
		local_mouse_pos = get_local_mouse_position()
		shoot(local_mouse_pos.normalized())
		Signals.player_ammo.emit(-1)
		timer = 0
		
	move_and_slide()


func shoot(launch_angle : Vector2) -> void:
	if not projectile_scene:
		return
	var projectile = projectile_scene.instantiate() as RigidBody2D
	
	get_tree().current_scene.add_child(projectile)

	projectile.global_position = global_position
	projectile.global_rotation = global_rotation
	
	projectile.global_position += launch_angle * Vector2(100,100)
	projectile.launch(launch_angle)
	
func pickup_blood(value : float):
	Signals.player_blood.emit(value)
	#print("blood: ", value)

func damage(value: float):
	Signals.player_health.emit(value)
	#print("damage: ", value)
	#print("died :(")

func vector_to_direction_8(dir: Vector2, deadzone: float = 0.2) -> int:
	if dir.length_squared() < deadzone * deadzone:
		return -1

	var angle: float = dir.angle()
	
	var shifted_angle: float = fposmod(angle + (PI / 2.0) + (PI / 8.0), TAU)
	
	return int(shifted_angle / (PI / 4.0))
