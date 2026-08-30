extends Node

## How the day ended, decided by the result dialogue and read by ResultDialogue
## once the conversation closes.
enum Ending {NONE, GAME_OVER, GAME_WIN}

@export var title_screen: PackedScene
@export var result_screen: PackedScene

var player: Player
var pause_ui: PauseUI
var inventory_ui: InventoryUI
var popup_container: PopupContainer
var map_manager: MapManager
## The result screen while it is on stage, so its dialogue can drive the fade.
var result_dialogue: ResultDialogue
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

# How the psychology reports scored, filled in by calculate_result() when the
# player takes the car back. The three are mutually exclusive: a report that is
# filled in but names the wrong owner lands in none of them.
var n_psy_profile = 3
var result_incomplete = 0
var result_correct_name = 0
var result_full_correct = 0

var ending: Ending = Ending.NONE

func _ready() -> void:
	pass


func go_back_to_title_screen() -> void:
	get_tree().paused = false
	Engine.time_scale = 1
	reset_data()
	get_tree().change_scene_to_packed(title_screen)

func go_to_result_screen() -> void:
	get_tree().change_scene_to_packed(result_screen)


func give_name_note(character: String) -> void:
	if character in acquired_name_note:
		return
	match character:
		"brother_do":
			inventory_ui.add_name_note("Brother Do")
		"do_nam_trung":
			inventory_ui.add_name_note("Do Nam Trung")
		"mister_dam":
			inventory_ui.add_name_note("Mister Dam")
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
		"do_nam_trung":
			inventory_ui.add_rule_paper([
				"Use WASD, not the arrow key, to move.",
				"Use Space button to shoot.",
				"Shoot all cans before time run out to win.",
				"The crosshair move up when you press the up button, and vice versa."
			], "Shooting Gallery")
		"mister_dam":
			inventory_ui.add_rule_paper([
				"Use the arrow key, not the WASD, to control your mini car.",
				"Avoid hitting other cars and reach the finish line to win.",
				"The car will move down when you press the down button."
			], "Obstacle Racing")
	show_item_popup("You got a new rule paper")
	acquired_rule_paper.append(character)


## Tallies every psychology report the player filled in, so the ending can
## branch on how well they did. Must run while the inventory is still in the
## tree, i.e. before leaving the map for the result scene.
func calculate_result() -> void:
	result_incomplete = 0
	result_correct_name = 0
	result_full_correct = 0
	for profile: PsyProfile in get_tree().get_nodes_in_group(PsyProfile.GROUP):
		if not profile.is_complete():
			result_incomplete += 1
		elif profile.is_full_correct():
			result_full_correct += 1
		elif profile.is_owner_name_correct():
			result_correct_name += 1


## Every stall was profiled, i.e. the manager has a full set of paperwork.
func is_all_report_complete() -> bool:
	return result_incomplete == 0


## Every report names the right stall owner, whatever the rules say.
func is_all_name_correct() -> bool:
	return result_correct_name + result_full_correct == n_psy_profile


## Every report is right down to the rule marks.
func is_all_full_correct() -> bool:
	return result_full_correct == n_psy_profile


func trigger_game_over() -> void:
	ending = Ending.GAME_OVER


func trigger_game_win() -> void:
	ending = Ending.GAME_WIN


## Show a short "new item" toast, if the current scene has a popup container.
func show_item_popup(content: String) -> void:
	if popup_container:
		popup_container.add_popup(content)

func reset_data():
	result_incomplete = 0
	result_correct_name = 0
	result_full_correct = 0
	ending = Ending.NONE
