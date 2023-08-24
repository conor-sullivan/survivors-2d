extends CharacterBody2D
class_name WizardEnemy

@onready var velocity_component: VelocityComponent = $VelocityComponent as VelocityComponent
@onready var visuals = $Visuals


func _process(delta):
	velocity_component.accelerate_to_player()
	velocity_component.move(self)

	var move_sign = sign(velocity.x)
	if move_sign != 0:
		visuals.scale = Vector2(move_sign, 1)
