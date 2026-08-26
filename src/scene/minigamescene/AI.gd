extends CharacterBody2D

@export var speed: float = 250

var direction: Vector2 = Vector2.ZERO
var ball

func _ready():
	ball = get_parent().find_child("Ball")


func _process(_delta: float) -> void:
	pass

func _physics_process(_delta):
	direction = Vector2(0,_get_direction())
	velocity = direction * speed
	move_and_slide()
	
func _get_direction():
	var distance = ball.position.y - self.position.y
	if abs(distance) > 50:
		return 1 if distance > 0 else -1
	return 0
