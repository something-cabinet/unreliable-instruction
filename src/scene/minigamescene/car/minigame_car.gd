extends Node2D
@export var car_scene: PackedScene
@export var winning_scene: PackedScene
@export var losing_scene: PackedScene
@export var false_input = true
@export var false_wincon = false
@export var false_movement = false

## Centre of each lane, matching the lane markings in minigame_car.tscn.
## Traffic used to spawn at randf_range(0, 5) * 300, which is up to y=1500 on a
## 768px screen, so roughly half of every wave sat below the view where the
## player could neither see nor hit it.
const LANE_Y := [114.0, 275.0, 435.0, 628.0]

## Emitted once when the round is over. The host listens for this to tear the
## minigame down and hand control back to the map.
signal finished(won: bool)

var lose = false
var win = false
# Renamed from `finished`, which now belongs to the signal above.
var game_over = false

# Several minigames share this script; a scene without a ResultUI still plays,
# it just has no banner to show.
@onready var result_ui: CanvasLayer = get_node_or_null("ResultUI")
@onready var result_label: Label = get_node_or_null("ResultUI/ResultLabel")

func _ready():
	# A previous run may have left the tree paused on its result screen.
	get_tree().paused = false
	if result_ui:
		result_ui.visible = false
	randomize()
	# The opening traffic is spread all the way up the road; later cars are
	# dropped further ahead so they don't appear on top of the player.
	for i in range(6):
		_spawn_car(1, 10)

func _on_timer_timeout() -> void:
	if game_over:
		return
	_spawn_car(5, 10)

# Drops one car in a random lane, somewhere between near and far quarter-screens
# ahead of the player. Nothing spawns past the finish line, since the player
# would never reach it.
func _spawn_car(near: float, far: float) -> void:
	var x = randf_range(near, far) * 250 + $player.position.x
	if x >= $FinishLine.position.x:
		return
	var car = car_scene.instantiate()
	car.spawn(x, LANE_Y[randi() % LANE_Y.size()])
	add_child(car)

func _process(_delta) -> void:
	if game_over:
		return
	get_tree().call_group("cars","check_pos")
	var cars = get_tree().get_nodes_in_group("cars")
	for object in cars:
		if object.hit:
			# Crashing into another car ends the run right away.
			_finish(false_wincon)
			return

func _on_finish_line_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if game_over:
		return
	_finish(not false_wincon)

# Freezes the minigame, shows the result banner, then hands the result back.
# Only this subtree is disabled -- pausing the whole tree would also freeze the
# host that is waiting on us, and the map behind it.
func _finish(did_win: bool) -> void:
	if game_over:
		return
	game_over = true
	win = did_win
	lose = not did_win
	if win:
		print("you won")
		if result_label:
			result_label.text = "YOU WIN"
			result_label.modulate = Color(0.4, 1.0, 0.45)
	else:
		print("you lost")
		if result_label:
			result_label.text = "YOU LOSE"
			result_label.modulate = Color(1.0, 0.35, 0.35)
	if result_ui:
		result_ui.visible = true
	var timer := get_node_or_null("Timer") as Timer
	if timer:
		timer.stop()
	# The banner's CanvasLayer runs with PROCESS_MODE_ALWAYS, so it stays up
	# while the traffic, the player and the scrolling road all sit still.
	process_mode = Node.PROCESS_MODE_DISABLED
	await get_tree().create_timer(2.0).timeout
	finished.emit(win)
