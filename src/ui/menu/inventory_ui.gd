extends Control
class_name InventoryUI

@export var name_note_prefab: PackedScene
@export var rule_paper_prefab: PackedScene

@onready var name_note_spawn: Control = $NameNoteSpawn
@onready var rule_paper_spawn: Control = $RulePaperSpawn

var name_note_count = 0
var rule_paper_count = 0
var MAX_COUNT_BEFORE_RESET = 7

func _ready() -> void:
	visible = false
	spawn_item_test()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_inventory"):
		visible = not visible

func spawn_item_test() -> void:
	for i in range(10):
		add_name_note()
		add_rule_paper()


func add_name_note() -> void:
	var item = name_note_prefab.instantiate()
	add_child(item)
	var offset_pos = Vector2((name_note_count % MAX_COUNT_BEFORE_RESET) * 100, randi_range(-100, 100))
	item.position = name_note_spawn.position + offset_pos
	name_note_count += 1

func add_rule_paper() -> void:
	var item = rule_paper_prefab.instantiate()
	add_child(item)
	var offset_pos = Vector2((rule_paper_count % MAX_COUNT_BEFORE_RESET) * 100, randi_range(-100, 100))
	item.position = rule_paper_spawn.position + offset_pos
	rule_paper_count += 1