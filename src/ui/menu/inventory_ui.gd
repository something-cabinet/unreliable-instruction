extends Control
class_name InventoryUI

@export var name_note_prefab: PackedScene
@export var rule_paper_prefab: PackedScene
@export var psy_profile_prefab: PackedScene
## One blank report is pinned to the board per entry, in this order. The size
## of this is what the ending counts against, so adding a stall owner here is
## all it takes to lengthen the day.
@export var psy_profile_data: Array[PsyProfileData] = []

@onready var name_note_spawn: Control = $NameNoteSpawn
@onready var rule_paper_spawn: Control = $RulePaperSpawn
@onready var psy_profile_container: VBoxContainer = $ScrollContainer/VBoxContainer

var name_note_count = 0
var rule_paper_count = 0
var MAX_COUNT_BEFORE_RESET = 7

func _ready() -> void:
	visible = false
	GameManager.inventory_ui = self
	spawn_psy_profiles()
	# spawn_item_test()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_inventory"):
		visible = not visible

# func spawn_item_test() -> void:
# 	for i in range(4):
# 		add_name_note()
# 		add_rule_paper()


## Pins one report per entry in [member psy_profile_data], clearing whatever
## the scene was authored with first.
func spawn_psy_profiles() -> void:
	for child in psy_profile_container.get_children():
		child.queue_free()
	for profile_data in psy_profile_data:
		var profile: PsyProfile = psy_profile_prefab.instantiate()
		psy_profile_container.add_child(profile)
		profile.data = profile_data
	GameManager.n_psy_profile = psy_profile_data.size()


func add_name_note(content: String) -> void:
	var item = name_note_prefab.instantiate()
	add_child(item)
	item.update_name(content)
	var offset_pos = Vector2((name_note_count % MAX_COUNT_BEFORE_RESET) * 100, randi_range(-100, 100))
	item.position = name_note_spawn.position + offset_pos
	name_note_count += 1

func add_rule_paper(content: Array[String], game_name: String) -> void:
	var item = rule_paper_prefab.instantiate()
	add_child(item)
	item.update_rule(content, game_name)
	var offset_pos = Vector2((rule_paper_count % MAX_COUNT_BEFORE_RESET) * 100, randi_range(-100, 100))
	item.position = rule_paper_spawn.position + offset_pos
	rule_paper_count += 1
