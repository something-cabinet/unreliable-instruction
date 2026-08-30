extends Node

@export var title_screen: PackedScene

var player: Player
var pause_ui: PauseUI
var inventory_ui: InventoryUI
var popup_container: PopupContainer
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

var acquired_name_note: Array[String] = []
var acquired_rule_paper: Array[String] = []

func _ready() -> void:
	pass


func go_back_to_title_screen():
	get_tree().paused = false
	Engine.time_scale = 1
	reset_data()
	get_tree().change_scene_to_packed(title_screen)

func give_name_note(character: String) -> void:
	if character in acquired_name_note:
		return
	match character:
		"brother_do":
			inventory_ui.add_name_note("Brother Do")
			show_item_popup("You got a new name note")
		"do_nam_trung":
			inventory_ui.add_name_note("Do Nam Trung")
			show_item_popup("You got a new name note")
	acquired_name_note.append(character)

func give_rule_paper(character: String) -> void:
	if character in acquired_rule_paper:
		return
	match character:
		"brother_do":
			inventory_ui.add_rule_paper([
				"Use WASD, not the arrow key, to move.",
				"Defend the ball until opponent missed to win.",
				"The slider move up when you press the up button, and vice versa."
			], "Pong Game")
			show_item_popup("You got a new rule paper")
		"do_nam_trung":
			inventory_ui.add_rule_paper([
				"Use WASD, not the arrow key, to move.",
				"Use Space button to shoot.",
				"Shoot all cans before time run out to win.",
				"The crosshair move up when you press the up button, and vice versa."
			], "Shooting Gallery")
			show_item_popup("You got a new rule paper")
	acquired_rule_paper.append(character)


## Show a short "new item" toast, if the current scene has a popup container.
func show_item_popup(content: String) -> void:
	if popup_container:
		popup_container.add_popup(content)

func reset_data():
	pass
