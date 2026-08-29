extends Area2D
@export var speed: float = 250
@export var hit : bool = false

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	position.x = position.x - speed * delta
	

func spawn(x,y):
	position.x = x
	position.y = y


func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	
	hit = true
	print("you hit the car")
