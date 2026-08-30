extends CharacterBody2D
class_name Interactable

@export var outline: Sprite2D

func _ready() -> void:
	outline.visible = false

func show_outline(is_show = false):
	outline.visible = is_show

func interact():
	pass
