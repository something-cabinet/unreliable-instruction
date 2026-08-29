extends Control

@export var dialogue_resource: DialogueResource
@export var day_one_scene: PackedScene


func _ready() -> void:
	DialogueManager.dialogue_ended.connect(finish_dialog.unbind(1))
	DialogueManager.show_dialogue_balloon(dialogue_resource)


func finish_dialog():
	get_tree().change_scene_to_packed(day_one_scene)
