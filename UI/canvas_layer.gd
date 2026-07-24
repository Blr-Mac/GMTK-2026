extends CanvasLayer




# Called when the node enters the scene tree for the first time.
func _ready():
	
	Signals.player_health.connect(_on_player_health)
	Signals.player_ammo.connect(_on_player_ammo)
	Signals.player_energy.connect(_on_player_energy)
	Signals.player_blood.connect(_on_player_blood)
	Signals.player_death.connect(_on_player_death)
	pass # Replace with function body.

func _on_player_health(health_changed : float):
	State.health += health_changed
	$Health.text = "health: " + str(State.health)

func _on_player_ammo(ammo_changed : float):
	State.ammo += ammo_changed
	$Ammo.text = "Ammo: " + str(State.ammo)

func _on_player_energy(energy_changed : float):
	State.energy += energy_changed
	$Energy.text = "Energy: " + str(State.energy)

func _on_player_blood(blood_changed : float):
	State.blood += blood_changed
	$Blood.text = "Blood: " + str(State.blood)

func _on_player_death():
	print("dead")
	get_tree().change_scene_to_file("res://menu/upgrade_panel.tscn")
