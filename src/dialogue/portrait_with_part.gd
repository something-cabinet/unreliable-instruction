extends TextureRect
class_name PortraitWithPart

@export var eye_part_truth_list: Array[Texture2D] = []
@export var eye_part_lie_list: Array[Texture2D] = []
@export var mouth_part_true_list: Array[Texture2D] = []
@export var mouth_part_lie_list: Array[Texture2D] = []


@onready var eye_l: TextureRect = $EyeL
@onready var eye_r: TextureRect = $EyeR
@onready var mouth: TextureRect = $Mouth


func _ready() -> void:
	assign_part()

func assign_part() -> void:
	eye_l.texture = eye_part_truth_list.pick_random()
	eye_r.texture = eye_l.texture
	mouth.texture = mouth_part_true_list.pick_random()
