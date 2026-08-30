extends Node2D

## Carnival shooting gallery. The crosshair moves with WASD; space or E fires.
## Clear every can on the shelves before the clock runs out and the round is
## won -- unless one of the flags below is lying about the rules.

## Swaps WASD for the arrow keys.
@export var false_input = false
## Inverts the goal: running the clock out wins, clearing the shelves loses.
@export var false_wincon = false
## Flips both movement axes.
@export var false_movement = false

## Seconds on the clock for the whole round.
@export var round_time: float = 20.0

## Emitted once when the round is over. The host listens for this to tear the
## minigame down and hand control back to the map.
signal finished(won: bool)

var lose = false
var win = false
# The crosshair reads this to stop taking input once the round is decided.
var game_over = false

var cans_left = 0
var time_left = 0.0

@onready var result_ui: CanvasLayer = get_node_or_null("ResultUI")
@onready var result_label: Label = get_node_or_null("ResultUI/ResultLabel")
@onready var time_label: Label = get_node_or_null("HUD/TimeLabel")
@onready var cans_label: Label = get_node_or_null("HUD/CansLabel")


func _ready() -> void:
	# A previous run may have left the tree paused on its result screen.
	get_tree().paused = false
	if result_ui:
		result_ui.visible = false
	time_left = round_time
	# The cans add themselves to the group in their own _ready, which has
	# already run by the time this parent's does.
	cans_left = get_tree().get_nodes_in_group("cans").size()
	_update_hud()


func _process(delta: float) -> void:
	if game_over:
		return
	time_left = maxf(time_left - delta, 0.0)
	_update_hud()
	if time_left == 0.0:
		# Timing out is normally a loss, but it is exactly what false_wincon
		# asks the player to do.
		_finish(false_wincon)


## Called by the crosshair each time it knocks a can over.
func on_can_shot() -> void:
	if game_over:
		return
	cans_left = maxi(cans_left - 1, 0)
	_update_hud()
	if cans_left == 0:
		# Let the last can finish falling before the banner covers it.
		await get_tree().create_timer(0.4).timeout
		_finish(not false_wincon)


func _update_hud() -> void:
	if time_label:
		time_label.text = "TIME  %0.1f" % time_left
	if cans_label:
		cans_label.text = "CANS  %d" % cans_left


func _finish(did_win: bool) -> void:
	if game_over:
		return
	game_over = true
	win = did_win
	lose = not did_win
	if result_label:
		if win:
			result_label.text = "YOU WIN"
			result_label.modulate = Color(0.4, 1.0, 0.45)
		else:
			result_label.text = "YOU LOSE"
			result_label.modulate = Color(1.0, 0.35, 0.35)
	if result_ui:
		result_ui.visible = true
	await get_tree().create_timer(2.0).timeout
	finished.emit(win)
