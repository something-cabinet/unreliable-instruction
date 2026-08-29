extends Node2D
class_name MapManager

const MINIGAME_HOST_SCENE := preload("res://src/scene/minigamescene/MinigameHost.tscn")

## Minigames addressable by name, so a .dialogue mutation can ask for one
## without needing a resource path.
const MINIGAME_SCENES := {
	"pong": preload("res://src/scene/minigamescene/pong/minigame_pong.tscn"),
}

## Emitted after a minigame has closed and the map is interactive again.
signal minigame_finished(won: bool)

var _minigame_host: MinigameHost = null


func _ready() -> void:
	GameManager.map_manager = self


## Opens a minigame over this map and waits for it to finish, returning whether
## the player won. Takes either a name from [constant MINIGAME_SCENES] or a
## PackedScene.
##
## This is a coroutine, so a blocking `do` mutation in a .dialogue file awaits
## it: the dialogue parks on that line until the minigame is over.
func start_minigame(minigame: Variant) -> bool:
	var scene: PackedScene = minigame if minigame is PackedScene else MINIGAME_SCENES.get(minigame)
	if scene == null:
		push_error("No minigame registered as '%s'" % minigame)
		return false
	if _minigame_host != null:
		return false

	# Dialogue Manager normally hides the balloon by itself during a slow
	# mutation, but it does that on a Timer owned by the balloon -- and the
	# balloon is a child of this map, so disabling the map below would freeze
	# that Timer and leave the panel sitting on top of the minigame. Hide it
	# here instead, and show it again when we're done.
	var balloon: Node = GameManager.dialogue_balloon
	if is_instance_valid(balloon):
		balloon.hide()

	_minigame_host = MINIGAME_HOST_SCENE.instantiate()
	_minigame_host.finished.connect(_on_minigame_finished)
	# Parented to the tree root rather than to the map, so disabling the map
	# doesn't freeze the minigame along with it.
	get_tree().root.add_child(_minigame_host)
	_minigame_host.run(scene)
	process_mode = Node.PROCESS_MODE_DISABLED

	return await minigame_finished


func _on_minigame_finished(won: bool) -> void:
	_minigame_host = null
	GameManager.last_minigame_won = won
	process_mode = Node.PROCESS_MODE_INHERIT
	if GameManager.player:
		GameManager.player.is_busy = false
	var balloon: Node = GameManager.dialogue_balloon
	if is_instance_valid(balloon):
		balloon.show()
	minigame_finished.emit(won)
