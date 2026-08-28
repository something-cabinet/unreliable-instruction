extends CharacterBody2D
@export var speed: float = 250

var direction: Vector2 = Vector2.ZERO
var win = false
var lose = false
var up
var down

func _ready():
	direction = Vector2.ZERO
	var game = get_parent()
	if game.false_input:
		if game.false_movement:
			up = "false_down"
			down = "false_up"
		else:
			up = "false_up"
			down = "false_down"
	else:
		if game.false_movement:
			up = "down"
			down = "up"
		else:
			up = "up"
			down = "down"

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta):
	if win:
		return
	if lose:
		return
		
	direction.y = Input.get_axis(up,down)

	velocity = direction * speed
	move_and_slide()
