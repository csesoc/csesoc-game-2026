# world.gd
class_name World
extends Node2D

@export var playerScene: PackedScene
@export var blockScene: PackedScene
@export var factoryScene: PackedScene

@onready var spawner: MultiplayerSpawner = $MultiplayerSpawner

var players: Dictionary = {}
var blocks: Array[Codeblock] = []
static var world

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawner.spawn_function = _spawn_player
	## add player
	#var player = playerScene.instantiate()
	#players.append(player)
	#add_child(player)
	
	var factory = factoryScene.instantiate()
	factory.position += Vector2(200, -100)
	add_child(factory)
	
	# add blocks
	for i in range(2):
		var block = blockScene.instantiate()
		block.name = "Block%d" % i
		block.position += Vector2(0, i * 50)
		blocks.append(block)
		add_child(block)
	
	world = self

static func getWorld():
	return world
	
func add_player(id: int) -> void:
	spawner.spawn(id)
	
func remove_player(id: int) -> void:
	if players.has(id):
		players[id].queue_free()
		players.erase(id)

func _spawn_player(id: int) -> Node:
	var player: Player = playerScene.instantiate()
	player.name = str(id)
	player.set_multiplayer_authority(id)
	players[id] = player
	return player

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
