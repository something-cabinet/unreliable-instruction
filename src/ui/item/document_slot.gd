extends ColorRect
class_name DocumentSlot

const GROUP := &"document_slot"

## Only items whose item_type matches this can be dropped here.
@export var accepted_type: String = ""
## Empty space kept between the slot border and the item snapped into it.
@export var padding = 0
## Temporary: prints the numbers used to centre an item, for diagnosing offsets.
@export var debug_centring := false

var occupant: DocumentItem = null


func _ready() -> void:
	add_to_group(GROUP)
	resized.connect(_recentre)


func can_accept(item: DocumentItem) -> bool:
	return item.item_type == accepted_type


func attach(item: DocumentItem) -> void:
	# Only one item fits, so whatever was here gets swapped back onto the board.
	if occupant != null and occupant != item:
		occupant.return_to_board()
	occupant = item
	# The slot's own size may not be resolved yet on the frame the item is
	# dropped, and a layout pass can overwrite position, so centre after both.
	_recentre.call_deferred()


func detach() -> void:
	occupant = null


func _recentre() -> void:
	if occupant == null or not is_instance_valid(occupant):
		return
	# Scale the item down so it fits inside the slot.
	var inner := size - Vector2(padding, padding) * 2.0
	var ratio := minf(1.0, minf(inner.x / occupant.size.x, inner.y / occupant.size.y))
	occupant.pivot_offset = occupant.size * 0.5
	occupant.scale = Vector2(ratio, ratio)
	# Measure where the item's centre actually lands rather than deriving it:
	# get_transform() folds in position, pivot, scale and rotation together.
	occupant.position = Vector2.ZERO
	var item_centre: Vector2 = occupant.get_transform() * (occupant.size * 0.5)
	occupant.position = size * 0.5 - item_centre
	if debug_centring:
		print("[slot %s] slot_size=%s item_size=%s ratio=%.3f item_centre=%s -> position=%s"
			% [name, size, occupant.size, ratio, item_centre, occupant.position])
