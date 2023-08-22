extends Node
class_name UpgradeManager

@export var upgrade_pool: Array[AbilityUpgrade]
@export var experiance_manager: ExperianceManager
@export var upgrade_screen_scene: PackedScene

var current_upgrades = {}

func _ready():
	experiance_manager.level_up.connect(on_level_up)


func on_level_up(current_level: int):
	var chosen_upgrade = upgrade_pool.pick_random() as AbilityUpgrade
	if not chosen_upgrade: return
	
	var upgrade_scene_instance = upgrade_screen_scene.instantiate() as UpgradeScene
	add_child(upgrade_scene_instance)
	upgrade_scene_instance.set_ability_upgrades([chosen_upgrade])
	upgrade_scene_instance.upgrade_selected.connect(on_upgrade_selected)

func apply_upgrade(upgrade: AbilityUpgrade):
	var has_upgrade = current_upgrades.has(upgrade.id)
	if not has_upgrade:
		current_upgrades[upgrade.id] = {
			"resource": upgrade,
			"quantity": 1
		}
	else:
		current_upgrades[upgrade.id]["quantity"] += 1
	
	GameEvents.ability_upgrade_added.emit(upgrade, current_upgrades)


func on_upgrade_selected(upgrade: AbilityUpgrade):
	apply_upgrade(upgrade) 
