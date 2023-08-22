extends Node
class_name ExperianceManager

signal experiance_updated(current_experiance: float, target_experiance: float)
signal level_up(new_level: int)

const TARGET_EXPERIANCE_GROWTH = 5

var current_experiance = 0
var current_level = 1
var target_experiance = 1

func _ready():
	GameEvents.experiance_vial_collected.connect(on_experiance_vial_collected)
	

func increment_experiance(number: float):
	current_experiance = min(current_experiance + number, target_experiance)
	experiance_updated.emit(current_experiance, target_experiance)
	if current_experiance == target_experiance:
		current_level += 1
		target_experiance += TARGET_EXPERIANCE_GROWTH
		current_experiance = 0
		experiance_updated.emit(current_experiance, target_experiance)
		level_up.emit(current_level)


func on_experiance_vial_collected(number: float):
	increment_experiance(number)
