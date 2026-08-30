@tool
extends HBoxContainer

signal state_changed(rule_is_true: bool)

@onready var button: Button = $Button
@onready var label: Label = $Label

var rule_is_true = true

func _ready() -> void:
	_refresh_button()


func _on_button_pressed() -> void:
	rule_is_true = not rule_is_true
	_refresh_button()
	state_changed.emit(rule_is_true)

func _refresh_button() -> void:
	if rule_is_true:
		button.text = "TRUE"
		button.self_modulate = Color.GREEN
	else:
		button.text = "LIE"
		button.self_modulate = Color.RED

func set_line_text(content: String) -> void:
	label.text = content
