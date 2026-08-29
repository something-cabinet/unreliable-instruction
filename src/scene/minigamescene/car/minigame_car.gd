extends Node2D
@export var car_scene: PackedScene
@export var winning_scene: PackedScene
@export var losing_scene: PackedScene
@export var false_input = true
@export var false_wincon = false
@export var false_movement = false

var lose = false
var win = false
var finished = false

@onready var result_ui: CanvasLayer = $ResultUI
@onready var result_label: Label = $ResultUI/ResultLabel

func _ready():
	# A previous run may have left the tree paused on its result screen.
	get_tree().paused = false
	result_ui.visible = false
	for i in range(6):
		var car = car_scene.instantiate()
		randomize()
		var x = randf_range(1,10) * 250 + $player.position.x
		var y = randf_range(0,5) * 300
		if x < $finishLine.position.x:
			car.spawn(x,y)
			add_child(car)

func _on_timer_timeout() -> void:
	if finished:
		return
	var car = car_scene.instantiate()

	randomize()
	var x = randf_range(5,10) * 250 + $player.position.x
	var y = randf_range(0,5) * 300
	if x < $finishLine.position.x:
		car.spawn(x,y)
		add_child(car)

func _process(_delta) -> void:
	if finished:
		return
	get_tree().call_group("cars","check_pos")
	var cars = get_tree().get_nodes_in_group("cars")
	for object in cars:
		if object.hit:
			# Crashing into another car ends the run right away.
			_finish(false_wincon)
			return

func _on_finish_line_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if finished:
		return
	_finish(not false_wincon)

# Freezes the minigame and shows the result banner. The banner's CanvasLayer
# runs with PROCESS_MODE_ALWAYS so it stays visible while the tree is paused.
func _finish(did_win: bool) -> void:
	finished = true
	win = did_win
	lose = not did_win
	if win:
		print("you won")
		result_label.text = "YOU WIN"
		result_label.modulate = Color(0.4, 1.0, 0.45)
	else:
		print("you lost")
		result_label.text = "YOU LOSE"
		result_label.modulate = Color(1.0, 0.35, 0.35)
	result_ui.visible = true
	$Timer.stop()
	get_tree().paused = true
