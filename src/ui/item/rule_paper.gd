@tool
extends DocumentItem
class_name RulePaper

@export var rule_line_prefab: PackedScene
@export var content: Array[String] = []
@export var game_name: String = ""

## One entry per rule line, mirroring the TRUE/LIE button state of that line.
var rule_states: Array[bool] = []

@onready var container: Container = $VBoxContainer
@onready var name_label: Label = $Name

func _ready() -> void:
    super()
    name_label.text = game_name
    _build_lines()

func update_rule(_content: Array[String], _game_name: String) -> void:
    content = _content
    game_name = _game_name
    name_label.text = game_name
    for child in container.get_children():
        child.queue_free()
    _build_lines()

func _build_lines() -> void:
    rule_states.clear()
    for i in content.size():
        var inst = rule_line_prefab.instantiate()
        container.add_child(inst)
        inst.set_line_text(content[i])
        rule_states.append(inst.rule_is_true)
        inst.state_changed.connect(_on_rule_state_changed.bind(i))

func _on_rule_state_changed(rule_is_true: bool, index: int) -> void:
    rule_states[index] = rule_is_true
