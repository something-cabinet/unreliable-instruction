extends Camera2D
class_name CameraFollow


var min_coord = Vector2(-464, -352)
var max_coord = Vector2(560, 16)

func _process(_delta: float) -> void:
	if GameManager.player:
		global_position = GameManager.player.global_position.clamp(min_coord, max_coord)
