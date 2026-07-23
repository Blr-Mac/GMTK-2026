extends CanvasLayer




# Called when the node enters the scene tree for the first time.
func _ready():
	
	Signals.player_health.connect(_on_player_health)
	Signals.player_ammo.connect(_on_player_ammo)
	Signals.player_energy.connect(_on_player_energy)
	Signals.player_blood.connect(_on_player_blood)
	pass # Replace with function body.

func _on_player_health(health_changed : float):
	$Health.text = "health: " + str(health_changed)

func _on_player_ammo(ammo_changed : float):
	$Ammo.text = "Ammo: " + str(ammo_changed)

func _on_player_energy(energy_changed : float):
	$Energy.text = "Energy: " + str(energy_changed)

func _on_player_blood(blood_changed : float):
	$Blood.text = "Blood: " + str(blood_changed)
