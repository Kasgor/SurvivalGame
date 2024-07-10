extends VBoxContainer
@onready var energy_bar = $EnergyBar
@onready var health_bar = $HealthBar


func _enter_tree():
	EventSystem.PLA_energy_updated.connect(energy_updated)
	EventSystem.PLA_health_updated.connect(health_updated)
	
	
func energy_updated(max_energy:float, current_energy:float):
	energy_bar.max_value = max_energy
	energy_bar.value= current_energy
	
func health_updated(max_health:float, current_health:float):
	health_bar.max_value = max_health
	health_bar.value= current_health
	
