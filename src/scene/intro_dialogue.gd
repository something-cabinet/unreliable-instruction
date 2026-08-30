extends Control

@export var dialogue_resource: DialogueResource
@export var day_one_scene: PackedScene

var bgm = preload("res://asset/bgm/Veruschka - Intervallo II ( Ennio Morricone ).mp3")

func _ready() -> void:
	DialogueManager.dialogue_ended.connect(finish_dialog.unbind(1))
	DialogueManager.show_dialogue_balloon(dialogue_resource)
	SoundManager.play_music_at_volume(bgm, 6)


func finish_dialog():
	get_tree().change_scene_to_packed(day_one_scene)
