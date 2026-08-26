extends Node2D


func _on_right_body_entered(body: Node2D) -> void:
	$Text.text = "You LOSE. I didn't specify which side"


func _on_left_body_entered(body: Node2D) -> void:
	$Text.text = "You WIN"
