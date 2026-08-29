extends Area2D
@export var speed: float = 200
@export var hit : bool = false
var size
var width
var height

func _ready() -> void:
	add_to_group("cars")
	size = $sprite.sprite_frames.get_frame_texture("default",0).get_size()
	width = size.x
	height = size.y

func _physics_process(delta: float) -> void:
	position.x = position.x - speed * delta
	

func spawn(x,y):
	position.x = x
	position.y = y

func get_height():
	return size.y

func get_width():
	return size.x
	
func check_pos():
	if position.x < 0:
		remove_from_group("cars")

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	
	hit = true
