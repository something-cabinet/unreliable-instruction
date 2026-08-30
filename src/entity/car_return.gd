extends Interactable

@export var dialogue_resource: DialogueResource

func interact():
	super()
	GameManager.player.is_busy = true
	GameManager.dialogue_balloon = DialogueManager.show_dialogue_balloon(dialogue_resource, "start")