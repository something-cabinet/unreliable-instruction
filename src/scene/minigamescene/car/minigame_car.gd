extends Node2D
@export var car_scene: PackedScene
@export var winning_scene: PackedScene
@export var losing_scene: PackedScene
@export var false_input = true
@export var false_wincon = false
@export var false_movement = false

var lose = false
var win = false

func _ready():
	for i in range(6):
		var car = car_scene.instantiate()
		randomize()
		var x = randf_range(1,10) * 250 + $player.position.x
		var y = randf_range(0,5) * 300
		if x < $finishLine.position.x:
			car.spawn(x,y)
			add_child(car)

func _on_timer_timeout() -> void:
	var car = car_scene.instantiate()

	randomize()
	var x = randf_range(5,10) * 250 + $player.position.x
	var y = randf_range(0,5) * 300
	if x < $finishLine.position.x:
		car.spawn(x,y)
		add_child(car)

func _process(_delta) -> void:
	get_tree().call_group("cars","check_pos")
	var cars = get_tree().get_nodes_in_group("cars")
	for object in cars:
		if object.hit:
			if false_wincon:
				win = true
				print("you won")
			else:
				lose = true
				print("you lost")			
			

func _on_finish_line_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if false_wincon:
		lose = true
		print("you lost")
	else:
		win = true
		print("you won")
