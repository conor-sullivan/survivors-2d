extends CanvasLayer

@export var experiance_manager: ExperianceManager
@onready var progress_bar: ProgressBar = $MarginContainer/ProgressBar

func _ready():
	progress_bar.value = 0
	experiance_manager.experiance_updated.connect(on_experiance_updated)
	
	
func on_experiance_updated(current_experiance: float, target_experiance: float):
	var percent = current_experiance / target_experiance
	progress_bar.value = percent
