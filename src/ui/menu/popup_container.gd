extends Control
class_name PopupContainer

## Small "you got a new item" toasts that appear in the lower right corner,
## rise up and fade away.

const MARGIN := Vector2(24, 24)
## Vertical gap between toasts that are on screen at the same time.
const STACK_SPACING := 8.0
## How far a toast travels upwards over its lifetime.
const RISE_DISTANCE := 48.0
const FADE_IN_TIME := 0.25
const HOLD_TIME := 1.8
const FADE_OUT_TIME := 0.6

## One entry per stacking slot, from the bottom up. A slot holds null while free
## so a finished toast never hands its place to one that is still on screen.
var popup_slots: Array[Control] = []

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	GameManager.popup_container = self


func add_popup(content: String) -> void:
	var popup := _build_popup(content)
	add_child(popup)
	var slot := popup_slots.find(null)
	if slot == -1:
		slot = popup_slots.size()
		popup_slots.append(popup)
	else:
		popup_slots[slot] = popup
	# Wait one frame so the panel has computed its size before we place it.
	await get_tree().process_frame
	if not is_instance_valid(popup):
		popup_slots[slot] = null
		return

	var start := Vector2(
		size.x - popup.size.x - MARGIN.x,
		size.y - popup.size.y - MARGIN.y - slot * (popup.size.y + STACK_SPACING)
	)
	popup.set_anchors_preset(Control.PRESET_BOTTOM_RIGHT, true)
	popup.position = start
	popup.modulate.a = 0.0

	var tween := create_tween()
	tween.tween_property(popup, "modulate:a", 1.0, FADE_IN_TIME)
	tween.parallel().tween_property(popup, "position:y", start.y - RISE_DISTANCE, \
			FADE_IN_TIME + HOLD_TIME + FADE_OUT_TIME).set_trans(Tween.TRANS_SINE)
	tween.tween_interval(HOLD_TIME)
	tween.tween_property(popup, "modulate:a", 0.0, FADE_OUT_TIME)
	await tween.finished

	popup_slots[slot] = null
	popup.queue_free()


func _build_popup(content: String) -> Control:
	var panel := PanelContainer.new()
	panel.mouse_filter = Control.MOUSE_FILTER_IGNORE

	var style := StyleBoxFlat.new()
	style.bg_color = Color(0.08, 0.08, 0.1, 0.85)
	style.border_color = Color(0.9, 0.82, 0.55, 0.9)
	style.set_border_width_all(2)
	style.set_corner_radius_all(6)
	style.set_content_margin_all(12)
	panel.add_theme_stylebox_override("panel", style)

	var label := Label.new()
	label.text = content
	label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	label.add_theme_font_size_override("font_size", 16)
	panel.add_child(label)

	return panel
