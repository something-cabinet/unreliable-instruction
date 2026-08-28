extends Control
class_name InventoryUI

func _ready() -> void:
	visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_inventory"):
		visible = not visible