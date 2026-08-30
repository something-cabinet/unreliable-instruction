extends Area2D

## The player's gun sight. Moves with WASD (or the arrow keys when the game is
## running its false_input variant) and shoots whatever can it is sitting on.
##
## Input action names are picked the same way the car and pong players pick
## theirs, from the three flags on the parent minigame.

@export var speed: float = 460.0
## Seconds between shots, so holding the key down doesn't clear the shelf.
@export var cooldown: float = 0.18
## The crosshair is clamped inside this rectangle, in the minigame's own
## coordinates, so it can't be driven off the screen.
@export var bounds: Rect2 = Rect2(60, 130, 1246, 560)

var up
var down
var left
var right

var _cooldown_left: float = 0.0

@onready var game = get_parent()
@onready var flash: Sprite2D = $Flash


func _ready() -> void:
	flash.visible = false
	if game.false_input:
		if game.false_movement:
			up = "false_down"
			down = "false_up"
			left = "false_right"
			right = "false_left"
		else:
			up = "false_up"
			down = "false_down"
			left = "false_left"
			right = "false_right"
	else:
		if game.false_movement:
			up = "down"
			down = "up"
			left = "right"
			right = "left"
		else:
			up = "up"
			down = "down"
			left = "left"
			right = "right"


func _physics_process(delta: float) -> void:
	if game.game_over:
		return

	var direction := Input.get_vector(left, right, up, down)
	position += direction * speed * delta
	position.x = clampf(position.x, bounds.position.x, bounds.end.x)
	position.y = clampf(position.y, bounds.position.y, bounds.end.y)

	_cooldown_left = maxf(_cooldown_left - delta, 0.0)
	if _cooldown_left == 0.0 and _shoot_pressed():
		_cooldown_left = cooldown
		_fire()


# Space/enter or the interact key both pull the trigger; neither is remapped by
# the false_input flag, which only ever lies about the movement keys.
func _shoot_pressed() -> bool:
	return Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("interact")


func _fire() -> void:
	_show_flash()
	# Overlaps are only cans (see the collision mask), but a can knocked over
	# earlier this frame may still be in the list, so skip anything already shot
	# and take whichever survivor is nearest the centre of the sight.
	var target = null
	var best := INF
	for area in get_overlapping_areas():
		var can: Variant = area
		if can.shot:
			continue
		var d := global_position.distance_squared_to(area.global_position)
		if d < best:
			best = d
			target = can
	if target:
		target.knock_over()
		game.on_can_shot()


func _show_flash() -> void:
	flash.visible = true
	flash.scale = Vector2(0.45, 0.45)
	flash.modulate.a = 1.0
	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property(flash, "scale", Vector2(0.9, 0.9), 0.12)
	tween.tween_property(flash, "modulate:a", 0.0, 0.12)
	tween.chain().tween_callback(func(): flash.visible = false)
