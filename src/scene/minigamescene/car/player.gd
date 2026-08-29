extends CharacterBody2D
@export var speed: float = 250

var direction: Vector2 = Vector2.ZERO
var up
var down
var left
var right

func _ready():
	direction = Vector2.ZERO
	var game = get_parent()
	if game.false_input:
		if game.false_movement:
			up = "false_down"
			down = "false_up"
			left = "false_right"
			right = "false_left"
		else:
			up = "false_up"
			down = "false_down"
			left = "false_left"
			right = "false_right"
	else:
		if game.false_movement:
			up = "down"
			down = "up"
			left = "right"
			right = "left"
		else:
			up = "up"
			down = "down"
			left = "left"
			right = "right"

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta):
		
	direction.y = Input.get_axis(up,down)

	velocity = direction * speed
	move_and_slide()
