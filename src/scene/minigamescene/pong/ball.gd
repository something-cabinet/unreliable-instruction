extends CharacterBody2D

class_name Ball

var speed: float = 250

var direction: Vector2 = Vector2(-1,-1)
var dead = false

func _ready():
	randomize()
	position.x = position.x + randf_range(400,600)
	

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta):
	if dead:
		return
	velocity = direction * speed * _delta
	var collision = move_and_collide(velocity)
	if collision:
		direction = direction.bounce(collision.get_normal())
		
func _stop():
	speed = 0
