extends Interactable
class_name StallOwner

@export var dialogue_resource: DialogueResource

func _ready() -> void:
	super()


func interact():
	super()
	GameManager.player.is_busy = true
	# Kept on GameManager so a `do` mutation can reach the balloon to hide it
	# while a minigame is running.
	GameManager.dialogue_balloon = DialogueManager.show_dialogue_balloon(dialogue_resource, "start")
