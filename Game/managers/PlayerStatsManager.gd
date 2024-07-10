extends Node

const  MAX_ENERGY: float = 100
const MAX_HEALTH: float = 100
var current_energy = MAX_ENERGY
var current_health = MAX_HEALTH

func _enter_tree()-> void:
	EventSystem.PLA_change_energy.connect(change_energy)
	EventSystem.PLA_change_health.connect(change_health)



func change_energy(energy_change: float):
	current_energy+= energy_change
	if current_energy <0 :
		change_health(energy_change)
		
	current_energy = clampf(current_energy, 0, MAX_ENERGY)
	
	EventSystem.PLA_energy_updated.emit(MAX_ENERGY, current_energy)


func change_health(health_change: float):
	current_health = clampf(current_health+health_change, 0, MAX_HEALTH)
	EventSystem.PLA_health_updated.emit(MAX_HEALTH, current_health)
