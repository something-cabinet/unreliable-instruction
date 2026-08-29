extends Area2D
@export var speed: float = 250

var lose : bool = false

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	position.x = position.x - speed * delta

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	lose = true
	
