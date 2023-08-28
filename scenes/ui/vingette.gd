extends CanvasLayer
class_name Vingette


func _ready():
	GameEvents.player_damaged.connect(on_player_damaged)


func on_player_damaged():
	$AnimationPlayer.play("hit")
