@tool
extends DocumentItem
class_name RulePaper

@export var rule_line_prefab: PackedScene
@export var content: Array[String] = []

@onready var container: Container = $VBoxContainer

func _ready() -> void:
    super()
    for item in content:
        var inst = rule_line_prefab.instantiate()
        container.add_child(inst)
        inst.set_line_text(item)

func update_rule(_content: Array[String]) -> void:
    content = _content
    for child in container.get_children():
        child.queue_free()
    for item in content:
        var inst = rule_line_prefab.instantiate()
        container.add_child(inst)
        inst.set_line_text(item)
