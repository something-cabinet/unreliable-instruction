extends Area2D

## One beer can on the shelf. Sits in the "cans" group so the minigame can
## count how many are still standing without holding references to them.

## Horizontal sway, in pixels either side of where the can was placed. Zero for
## a stationary can.
@export var sway_amplitude: float = 0.0
@export var sway_speed: float = 1.5

var shot = false

var _origin_x: float = 0.0
var _phase: float = 0.0

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	add_to_group("cans")
	_origin_x = position.x
	# Cans placed at the same time would otherwise sway in lockstep.
	_phase = randf() * TAU


func _process(delta: float) -> void:
	if shot or sway_amplitude == 0.0:
		return
	_phase += delta * sway_speed
	position.x = _origin_x + sin(_phase) * sway_amplitude


## Knocks the can off its shelf. Safe to call twice: only the first call counts.
func knock_over() -> void:
	if shot:
		return
	shot = true
	# Stop the sway and take the can out of the crosshair's overlap set, so a
	# second shot at the same spot can't hit it again while it falls.
	monitorable = false
	collision.set_deferred("disabled", true)

	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property(sprite, "rotation_degrees", 80.0, 0.35)
	tween.tween_property(sprite, "position:y", sprite.position.y + 70.0, 0.35)
	tween.tween_property(sprite, "modulate:a", 0.0, 0.35).set_delay(0.1)
