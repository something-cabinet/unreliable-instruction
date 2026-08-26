extends CharacterBody2D
class_name StallOwner

@onready var outline: Sprite2D = $Outline

func _ready() -> void:
	outline.visible = false

func show_outline(is_show = false):
		outline.visible = is_show
