extends CharacterBody2D

class_name Ball

var speed: float = 5000

var direction: Vector2 = Vector2.ONE
var dead = false

func _ready():
	direction = Vector2(-1.0,1.0)

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta):
	if dead:
		return
	velocity = direction * speed
	var collision = move_and_collide(direction)
	if collision:
		direction = direction.bounce(collision.get_normal())
