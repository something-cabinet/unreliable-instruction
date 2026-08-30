@tool
extends HBoxContainer

@onready var button: Button = $Button
@onready var label: Label = $Label

var rule_is_true = true

func _ready() -> void:
	button.text = "TRUE"
	button.self_modulate = Color.GREEN


func _on_button_pressed() -> void:
	rule_is_true = not rule_is_true
	if rule_is_true:
		button.text = "TRUE"
		button.self_modulate = Color.GREEN
	else:
		button.text = "LIE"
		button.self_modulate = Color.RED

func set_line_text(content: String) -> void:
	label.text = content
