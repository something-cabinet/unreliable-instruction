extends Node2D
@export var false_input = false
@export var false_wincon = false
@export var false_movement = true

## Emitted once when the round is over. The host listens for this to tear the
## minigame down and hand control back to the map.
signal finished(won: bool)

var lose = false
var win = false

# Mirrors the car minigame's result banner. Optional so a court laid out
# without a ResultUI still plays, it just shows nothing.
@onready var result_ui: CanvasLayer = get_node_or_null("ResultUI")
@onready var result_label: Label = get_node_or_null("ResultUI/ResultLabel")


func _ready():
	if result_ui:
		result_ui.visible = false


func _process(_delta: float) -> void:
	pass


func _on_right_body_entered(_body: Node2D) -> void:
	if false_wincon:
		_end_round(false)
	else:
		_end_round(true)


func _on_left_body_entered(_body: Node2D) -> void:
	if false_wincon:
		_end_round(true)
	else:
		_end_round(false)


func _end_round(won: bool) -> void:
	# Both goal areas can trigger on the same frame if the ball clips a corner,
	# so the first result is the one that counts.
	if win or lose:
		return
	win = won
	lose = not won
	# Freeze the paddles and ball so the court sits still for the beat before
	# the minigame closes.
	$Player.win = won
	$Player.lose = not won
	$Ball.dead = true
	if result_label:
		if won:
			result_label.text = "YOU WIN"
			result_label.modulate = Color(0.4, 1.0, 0.45)
		else:
			result_label.text = "YOU LOSE"
			result_label.modulate = Color(1.0, 0.35, 0.35)
	if result_ui:
		result_ui.visible = true
	await get_tree().create_timer(2.0).timeout
	finished.emit(won)
