@tool
extends DocumentItem
class_name NameNote

@export var content: String = ""

@onready var label: Label = $Label


func _ready() -> void:
    super()
    label.text = content


func update_name(_content: String) -> void:
    content = _content
    label.text = content
