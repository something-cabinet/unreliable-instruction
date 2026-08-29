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
	# Kept on GameManager so a `do` mutation can reach the balloon to hide it
	# while a minigame is running.
	GameManager.dialogue_balloon = DialogueManager.show_dialogue_balloon(dialogue_resource, "start")
