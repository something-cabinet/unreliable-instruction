extends Camera2D
class_name CameraFollow


var min_coord = Vector2(-2268, -352)
var max_coord = Vector2(890, 16)


func _ready() -> void:
	GameManager.camera = self

func _process(_delta: float) -> void:
	if GameManager.player:
		global_position = GameManager.player.global_position.clamp(min_coord, max_coord)
