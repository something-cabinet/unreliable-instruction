extends CharacterBody2D
class_name Player

@export var speed: float = 200

@onready var interact_label: Label = $InteractLabel

var direction: Vector2 = Vector2.ZERO
var dead = false
var current_interactable: Interactable = null
var is_busy = false

func _ready():
	GameManager.player = self
	interact_label.visible = false
	DialogueManager.dialogue_ended.connect(finish_interaction.unbind(1))


func _process(_delta: float) -> void:
	pass

func _physics_process(_delta):
	if dead or is_busy:
		return
	direction = Vector2.ZERO
	direction = Input.get_vector("left", "right", "up", "down")

	velocity = direction * speed
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		interact()


func interact():
	if is_busy:
		return

	if current_interactable != null:
		current_interactable.interact()


func finish_interaction():
	is_busy = false

func _on_interact_area_body_entered(body: Node2D) -> void:
	if body is Interactable:
		body.show_outline(true)
		interact_label.visible = true
		current_interactable = body

func _on_interact_area_body_exited(body: Node2D) -> void:
	if body is Interactable:
		body.show_outline(false)
		interact_label.visible = false
		current_interactable = null
