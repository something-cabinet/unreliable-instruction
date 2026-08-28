extends Control
class_name DocumentItem

@export var allow_dragging = false
## Must match a DocumentSlot's accepted_type for that slot to take this item.
@export var item_type: String = ""

var _dragging := false
var _drag_offset := Vector2.ZERO
var _home_parent: Node = null
# Where this item last sat on the board, so it can go back there if swapped out.
var _board_position := Vector2.ZERO


func _ready() -> void:
	_home_parent = get_parent()


func _gui_input(event: InputEvent) -> void:
	if not allow_dragging:
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		_begin_drag()
		accept_event()


# Dragging out of a slot reparents this node, which makes the viewport drop its
# GUI mouse focus, so the release would never reach _gui_input. Once a drag is
# under way we listen at the input level instead, where nothing can steal it.
func _input(event: InputEvent) -> void:
	if not _dragging:
		return
	if event is InputEventMouseMotion:
		global_position = _clamp_to_window(get_global_mouse_position() - _drag_offset)
		get_viewport().set_input_as_handled()
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		_end_drag()
		get_viewport().set_input_as_handled()


func _begin_drag() -> void:
	if get_parent() is DocumentSlot:
		_leave_slot()
	else:
		_board_position = global_position
	_dragging = true
	_drag_offset = get_global_mouse_position() - global_position
	move_to_front()


func _end_drag() -> void:
	_dragging = false
	var slot := _slot_under_item()
	if slot != null:
		reparent(slot)
		slot.attach(self)


# Puts the item back on the board where it last sat, used when another item is
# dropped into the slot this one occupies.
func return_to_board() -> void:
	_leave_slot()
	global_position = _clamp_to_window(_board_position)


# Pulls the item back out onto the board it started on, at its current
# on-screen position, so a slotted item can be dragged away again.
func _leave_slot() -> void:
	var slot := get_parent() as DocumentSlot
	if slot == null:
		return
	slot.detach()
	reparent(_home_parent)
	scale = Vector2.ONE


func _slot_under_item() -> DocumentSlot:
	var centre := get_global_rect().get_center()
	for slot: DocumentSlot in get_tree().get_nodes_in_group(DocumentSlot.GROUP):
		if not slot.is_visible_in_tree() or not slot.can_accept(self):
			continue
		if slot.get_global_rect().has_point(centre) and _is_point_unclipped(slot, centre):
			return slot
	return null


# A slot scrolled out of view still has a global rect, so also require the drop
# point to be inside every clipping ancestor (the ScrollContainer) above it.
func _is_point_unclipped(slot: Control, point: Vector2) -> bool:
	var node := slot.get_parent()
	while node is Control:
		var control := node as Control
		if control.clip_contents and not control.get_global_rect().has_point(point):
			return false
		node = control.get_parent()
	return true


# Keeps the whole item inside the visible viewport. If the item is bigger than
# the window on an axis, it stays pinned to the top/left edge of that axis.
func _clamp_to_window(target: Vector2) -> Vector2:
	var bounds := get_viewport_rect()
	var max_position := bounds.end - size
	return target.clamp(bounds.position, bounds.position.max(max_position))
