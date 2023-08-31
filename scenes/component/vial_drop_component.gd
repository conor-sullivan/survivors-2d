extends Node
class_name VialDropComponent

@export_range(0, 1) var drop_percent: float = 0.5
@export var HealthComponent: HealthComponent
@export var vial_scene: PackedScene


func _ready():
	HealthComponent.died.connect(on_died)


func on_died():
	var adjusted_drop_percent = drop_percent
	var experiance_gain_upgrade_count = MetaProgression.get_upgrade_count("experiance_gain")
	if experiance_gain_upgrade_count > 0:
		adjusted_drop_percent += 0.1
	if randf() > adjusted_drop_percent: return
	
	if not vial_scene: return
	if not owner is Node2D: return
	
	var spawn_position = (owner as Node2D).global_position
	var vial_instance = vial_scene.instantiate() as Node2D
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	entities_layer.add_child(vial_instance)
	vial_instance.global_position = spawn_position
