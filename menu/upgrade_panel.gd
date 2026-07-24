extends Node2D

@onready var start = $CanvasLayer/start_button

# Called when the node enters the scene tree for the first time.
func _ready():
	start.pressed.connect(_on_button_pressed)
	pass # Replace with function body.


func _on_button_pressed() -> void:
	print("Button was clicked!")
	State.health = 3
	State.ammo = 3
	State.energy = 10
	get_tree().change_scene_to_file("res://main.tscn")
