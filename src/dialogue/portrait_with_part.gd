extends TextureRect
class_name PortraitWithPart

@export_group("Eyes")
@export var eye_truth: Array[Texture2D] = []
@export var eye_lie: Array[Texture2D] = []

@export_group("Mouth")
@export var mouth_truth: Array[Texture2D] = []
@export var mouth_lie: Array[Texture2D] = []

@export_group("Arm")
@export var arm_truth: Array[Texture2D] = []
@export var arm_truth_left_only: Array[Texture2D] = []
@export var arm_truth_right_only: Array[Texture2D] = []
@export var arm_lie: Array[Texture2D] = []
@export var arm_lie_left_only: Array[Texture2D] = []
@export var arm_lie_right_only: Array[Texture2D] = []

@onready var eye_l: TextureRect = $EyeL
@onready var eye_r: TextureRect = $EyeR
@onready var mouth: TextureRect = $Mouth
@onready var arm_l: TextureRect = $ArmL
@onready var arm_r: TextureRect = $ArmR

@export_group("Arm Sway")
## Max rotation of the pendulum swing, in degrees.
@export var arm_sway_degrees: float = 4.0
## Full swings per second.
@export var arm_sway_speed: float = 0.6

@export_group("Face Breathing")
## How far the eyes squeeze/expand vertically, as a fraction of their size.
@export var eye_squash_amount: float = 0.12
## Eye squeeze cycles per second.
@export var eye_squash_speed: float = 0.9
## How far the mouth squeezes/expands horizontally, as a fraction of its size.
@export var mouth_squash_amount: float = 0.08
## Mouth squeeze cycles per second.
@export var mouth_squash_speed: float = 0.7

var is_telling_truth = false

var _sway_time: float = 0.0

func _ready() -> void:
	assign_part(true)


func _process(delta: float) -> void:
	_sway_time += delta
	var angle := deg_to_rad(arm_sway_degrees) * sin(_sway_time * arm_sway_speed * TAU)
	# Mirror the arms so they swing away from each other.
	arm_l.rotation = angle
	arm_r.rotation = - angle

	var eye_scale_y := 1.0 + eye_squash_amount * sin(_sway_time * eye_squash_speed * TAU)
	eye_l.scale.y = eye_scale_y
	eye_r.scale.y = eye_scale_y

	mouth.scale.x = 1.0 + mouth_squash_amount * sin(_sway_time * mouth_squash_speed * TAU)

func assign_part(_is_telling_truth: bool = true) -> void:
	is_telling_truth = _is_telling_truth
	if not is_telling_truth:
		eye_l.texture = eye_lie.pick_random()
		eye_r.texture = eye_l.texture
		mouth.texture = mouth_lie.pick_random()
		arm_l.texture = (arm_lie + arm_lie_left_only).pick_random()
		arm_r.texture = (arm_lie + arm_lie_right_only).pick_random()
	else:
		eye_l.texture = eye_truth.pick_random()
		eye_r.texture = eye_l.texture
		mouth.texture = mouth_truth.pick_random()
		arm_l.texture = (arm_truth + arm_truth_left_only).pick_random()
		arm_r.texture = (arm_truth + arm_truth_right_only).pick_random()


func _on_timer_timeout() -> void:
	assign_part()
