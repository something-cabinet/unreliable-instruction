extends TextureRect
class_name PortraitWithPart

@export var eye_part_truth_list: Array[Texture2D] = []
@export var mouth_part_truth_list: Array[Texture2D] = []
@export var arm_part_truth_list: Array[Texture2D] = []

@export var eye_part_lie_list: Array[Texture2D] = []
@export var mouth_part_lie_list: Array[Texture2D] = []
@export var arm_part_lie_list: Array[Texture2D] = []


@onready var eye_l: TextureRect = $EyeL
@onready var eye_r: TextureRect = $EyeR
@onready var mouth: TextureRect = $Mouth
@onready var arm_l: TextureRect = $ArmL
@onready var arm_r: TextureRect = $ArmR


func _ready() -> void:
	assign_part()

func assign_part() -> void:
	eye_l.texture = eye_part_truth_list.pick_random()
	eye_r.texture = eye_l.texture
	mouth.texture = mouth_part_truth_list.pick_random()
	arm_l.texture = arm_part_truth_list.pick_random()
	arm_r.texture = arm_part_truth_list.pick_random()


func _on_timer_timeout() -> void:
	assign_part()
