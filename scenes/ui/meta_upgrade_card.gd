extends PanelContainer
class_name MetaUpgradeCard

@onready var animation_player = $AnimationPlayer
@onready var name_label: Label = %NameLabel
@onready var description_label: Label = %DescriptionLabel
@onready var progress_bar = %ProgressBar
@onready var purchase_button = %PurchaseButton
@onready var progress_label = %ProgressLabel
@onready var count_label = %CountLabel

var upgrade: MetaUpgrade


func _ready():
	purchase_button.pressed.connect(on_purchase_pressed)


func update_progress():
	var current_quantity = 0
	if MetaProgression.save_data["meta_upgrades"].has(upgrade.id):
		current_quantity = MetaProgression.save_data["meta_upgrades"][upgrade.id]["quantity"]
	var currency = MetaProgression.save_data["meta_upgrade_currency"]
	var percent = currency / upgrade.experiance_cost
	var is_maxed = current_quantity >= upgrade.max_quantity
	percent = min(percent, 1)
	progress_bar.value = percent
	purchase_button.disabled = percent < 1 or current_quantity >= upgrade.max_quantity
	if is_maxed: purchase_button.text = "Max"
	progress_label.text = str(currency) + "/" + str(upgrade.experiance_cost)
	count_label.text = "x%d" % current_quantity


func set_meta_upgrade(new_upgrade: MetaUpgrade):
	self.upgrade = new_upgrade
	name_label.text = new_upgrade.title
	description_label.text = new_upgrade.description
	update_progress()


func select_card():
	animation_player.play("selected")
	MetaProgression.add_meta_upgrade(upgrade)
	MetaProgression.save_data["meta_upgrade_currency"] -= upgrade.experiance_cost
	MetaProgression.save()
	get_tree().call_group("meta_upgrade_card", "update_progress")


func on_purchase_pressed():
	if not upgrade: return
	select_card()
