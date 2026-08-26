extends CharacterBody2D
class_name StallOwner

@export var dialogue_resource: DialogueResource

@onready var outline: Sprite2D = $Outline

func _ready() -> void:
	outline.visible = false

func show_outline(is_show = false):
		outline.visible = is_show

func interact():
	GameManager.player.is_busy = true
	DialogueManager.show_dialogue_balloon(dialogue_resource, "start")
