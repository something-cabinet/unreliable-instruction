extends Node2D
@export var car_scene: PackedScene
@export var false_input = true
@export var false_wincon = false
@export var false_movement = false

var lose = false
var win = false

func _on_timer_timeout() -> void:
	var car = car_scene.instantiate()
	randomize()
	
	car.spawn(randf_range(500,2000),randf_range(100,500))
	add_child(car)


func _on_finish_line_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if false_wincon:
		lose = true
		print("you lost")
	else:
		win = true
		print("you won")
