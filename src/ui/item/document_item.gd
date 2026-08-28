extends Control
class_name DocumentItem

@export var allow_dragging = false

var _dragging := false
var _drag_offset := Vector2.ZERO


func _gui_input(event: InputEvent) -> void:
	if not allow_dragging:
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			_dragging = true
			_drag_offset = get_global_mouse_position() - global_position
			move_to_front()
		else:
			_dragging = false
		accept_event()
	elif event is InputEventMouseMotion and _dragging:
		global_position = get_global_mouse_position() - _drag_offset
		accept_event()
