extends CharacterBody2D
@export var speed: float = 250

var direction: Vector2 = Vector2.ZERO
var win = false
var lose = false
var left
var right

func _ready():
	direction = Vector2.ZERO
	var game = get_parent()
	if game.false_input:
		if game.false_movement:
			left = "false_right"
			right = "false_left"
		else:
			left = "false_left"
			right = "false_right"
	else:
		if game.false_movement:
			left = "right"
			right = "left"
		else:
			left = "left"
			right = "right"

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta):
	if win:
		return
	if lose:
		return
		
	direction.x = Input.get_axis(left,right)

	velocity = direction * speed
	move_and_slide()
