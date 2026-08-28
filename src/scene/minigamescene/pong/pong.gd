extends Node2D
@export var false_input = false
@export var false_wincon = false
@export var false_movement = true

var lose = false
var win = false

func _ready():
	pass
	
func _process(delta: float) -> void:
	if win:
		print("You won")
		return
	if lose:
		print("You lose")
		return
		
func _on_right_body_entered(body: Node2D) -> void:
	if false_wincon:
		lose = true
	else:
		win = true



func _on_left_body_entered(body: Node2D) -> void:
	if false_wincon:
		win = true
	else:
		lose = true
