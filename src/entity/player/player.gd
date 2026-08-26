extends CharacterBody2D
class_name Player

@export var speed: float = 200

@onready var interact_label: Label = $InteractLabel

var direction: Vector2 = Vector2.ZERO
var dead = false

func _ready():
	GameManager.player = self
	interact_label.visible = false


func _process(_delta: float) -> void:
	pass

func _physics_process(_delta):
	if dead:
		return
	direction = Vector2.ZERO
	direction = Input.get_vector("left", "right", "up", "down")

	velocity = direction * speed
	move_and_slide()


func _on_interact_area_body_entered(body: Node2D) -> void:
	if body is StallOwner:
		body.show_outline(true)
		interact_label.visible = true

func _on_interact_area_body_exited(body: Node2D) -> void:
	if body is StallOwner:
		body.show_outline(false)
		interact_label.visible = false
