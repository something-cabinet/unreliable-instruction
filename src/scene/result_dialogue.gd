extends Control
class_name ResultDialogue

@export var dialogue_resource: DialogueResource
## Where the day lands once the manager is finished. Left unset they both fall
## back to the title screen.
@export var game_over_scene: PackedScene
@export var game_win_scene: PackedScene

## Seconds for the screen to go black, and again to come back.
@export var fade_duration := 0.8
## How long the screen stays black while the manager reads the reports.
@export var away_duration := 1.2

@onready var fade_overlay: ColorRect = $FadeLayer/FadeOverlay

var bgm = preload("res://asset/bgm/Veruschka - Intervallo II ( Ennio Morricone ).mp3")

func _ready() -> void:
	GameManager.result_dialogue = self
	fade_overlay.color.a = 0.0
	fade_overlay.visible = false
	DialogueManager.dialogue_ended.connect(finish_dialog.unbind(1))
	DialogueManager.show_dialogue_balloon(dialogue_resource)
	SoundManager.play_music_at_volume(bgm, 6)


## Fades to black, holds while the manager is off reading the paperwork, then
## fades back in. The dialogue awaits this, so the next line waits for the fade.
func fade_out_and_back() -> void:
	fade_overlay.visible = true
	var tween := create_tween()
	tween.tween_property(fade_overlay, "color:a", 1.0, fade_duration)
	tween.tween_interval(away_duration)
	tween.tween_property(fade_overlay, "color:a", 0.0, fade_duration)
	await tween.finished
	fade_overlay.visible = false


func finish_dialog() -> void:
	var next: PackedScene = game_win_scene if GameManager.ending == GameManager.Ending.GAME_WIN else game_over_scene
	if next == null:
		GameManager.go_back_to_title_screen()
		return
	get_tree().change_scene_to_packed(next)
