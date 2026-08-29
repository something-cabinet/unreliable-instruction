extends CharacterBody2D

class_name Ball

@export var speed: float = 500
@export var paddle_spin: float = 0.4
@export var max_deflection: float = 0.85

var direction: Vector2 = Vector2.ONE
var dead = false

func _ready():
	direction = Vector2(-1.0, 1.0).normalized()

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta):
	if dead:
		return
	velocity = direction * speed * _delta
	var collision = move_and_collide(velocity)
	if collision:
		direction = direction.bounce(collision.get_normal())
		var collider = collision.get_collider()
		if collider is CharacterBody2D:
			_apply_paddle_spin(collider, collision.get_normal())

# A paddle moving as it hits drags the ball along with it, so the player can aim
# the return instead of only mirroring the incoming angle.
func _apply_paddle_spin(paddle: CharacterBody2D, normal: Vector2) -> void:
	# Only the front faces impart spin; a nick on the paddle's top or bottom
	# edge keeps its plain bounce.
	if absf(normal.x) < 0.5:
		return
	if paddle.speed <= 0:
		return
	var kick = paddle.velocity.y / paddle.speed
	direction.y = clampf(direction.y + kick * paddle_spin, -max_deflection, max_deflection)
	# max_deflection keeps |x| well above zero here, so the ball always keeps
	# crossing the court instead of stalling into a vertical bounce.
	direction = direction.normalized()

func _stop():
	speed = 0
