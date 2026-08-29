extends CanvasLayer
class_name MinigameHost

## Runs a minigame scene full-screen on top of whatever map is currently loaded.
##
## The minigame lives inside a SubViewport, so it keeps its own World2D: its
## paddles and ball can never collide with the map's player, and it can use the
## screen-sized coordinates it was authored with while the map camera is off
## somewhere else entirely.

signal finished(won: bool)

@onready var sub_viewport: SubViewport = $SubViewportContainer/SubViewport

var minigame: Node = null


func run(minigame_scene: PackedScene) -> void:
	minigame = minigame_scene.instantiate()
	minigame.finished.connect(_on_minigame_finished)
	sub_viewport.add_child(minigame)


func _on_minigame_finished(won: bool) -> void:
	finished.emit(won)
	queue_free()
