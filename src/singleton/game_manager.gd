extends Node

@export var title_screen: PackedScene

var player: Player
var pause_ui: PauseUI
var inventory_ui: InventoryUI
var map_manager: MapManager
var camera: Camera2D
## The balloon for the dialogue currently on screen, if any.
var dialogue_balloon: Node
## Result of the last minigame, so dialogue can branch on it after the fact.
var last_minigame_won := false

# Setting
var fps_limit_index = 2 # From 0 to 5. Refer to EnumAutoload.FPS_LIMIT_ARRAY
var resolution_index = 4 # From 0 to 6. Refer to EnumAutoload.RESOLUTION_ARRAY. Not used in FULL_SCREEN
var vsync_option_index = 1
var window_mode_index = 1 # From 0 to 2
var master_audio = 80
var bgm_audio = 100
var sfx_audio = 100
var ui_audio = 100

func _ready() -> void:
	pass


func go_back_to_title_screen():
	get_tree().paused = false
	Engine.time_scale = 1
	reset_data()
	get_tree().change_scene_to_packed(title_screen)

func give_name_note(character: String) -> void:
	match character:
		"brother_do":
			inventory_ui.add_name_note("Brother Do")
		"do_name_trung":
			inventory_ui.add_name_note("Do Nam Trung")

func give_rule_paper(character: String) -> void:
	match character:
		"brother_do":
			inventory_ui.add_rule_paper([
				"Use WASD, not the arrow key, to move.",
				"Defend the ball until opponent missed to win.",
				"The slider move up when you press the up button, and vice versa."
			])

func reset_data():
	pass
