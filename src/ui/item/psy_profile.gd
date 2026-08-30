@tool
extends DocumentItem
class_name PsyProfile

## Fires whenever an attached document changes, so the report readout can update.
signal report_changed

@export var pattern_line_prefab: PackedScene
@export var lying_patterns: Array[String] = []

@export var correct_stall_owner_name: String
@export var correct_game_name: String
@export var correct_rule_states: Array[bool] = []


## Copied from the NameNote dropped into NameNoteSlot.
var stall_owner_name: String = ""
## Copied from the RulePaper dropped into RulePaperSlot.
var game_name: String = ""
## The RulePaper's TRUE/LIE marks. Kept as a live reference to the paper's own
## array so later marking still shows up here; empty while no paper is attached.
var rule_states: Array[bool] = []

@onready var container: Container = $VBoxContainer
@onready var name_note_slot: DocumentSlot = $NameNoteSlot
@onready var rule_paper_slot: DocumentSlot = $RulePaperSlot

func _ready() -> void:
	for child in container.get_children():
		child.queue_free()
	for item in lying_patterns:
		var inst: Label = pattern_line_prefab.instantiate()
		container.add_child(inst)
		inst.text = item
	if Engine.is_editor_hint():
		return
	name_note_slot.occupant_changed.connect(_on_name_note_changed)
	rule_paper_slot.occupant_changed.connect(_on_rule_paper_changed)

func _on_name_note_changed(item: DocumentItem) -> void:
	var note := item as NameNote
	stall_owner_name = note.content if note != null else ""
	report_changed.emit()

func _on_rule_paper_changed(item: DocumentItem) -> void:
	var paper := item as RulePaper
	if paper != null:
		game_name = paper.game_name
		rule_states = paper.rule_states
	else:
		game_name = ""
		rule_states = [] as Array[bool]
	report_changed.emit()

## True once both documents are attached, i.e. the report can be checked.
func is_complete() -> bool:
	return stall_owner_name != "" and game_name != "" and not rule_states.is_empty()


func is_owner_name_correct() -> bool:
	return stall_owner_name == correct_stall_owner_name


func is_full_correct() -> bool:
	if not is_complete():
		return false
	return stall_owner_name == correct_stall_owner_name and \
		game_name == correct_game_name and \
		rule_states == correct_rule_states