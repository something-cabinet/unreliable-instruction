extends Control

@export var dialog_resource: DialogueResource


func _ready() -> void:
	DialogueManager.show_dialogue_balloon(dialog_resource)
