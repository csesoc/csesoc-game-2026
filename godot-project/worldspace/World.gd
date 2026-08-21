# world.gd
class_name World
extends Node2D

@export var playerScene: PackedScene
@export var blockScene: PackedScene
@export var factoryScene: PackedScene

var players: Array[Player] = []
var blocks: Array[Codeblock] = []
static var world

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
		block.position += Vector2(0, i * 50)
		blocks.append(block)
		add_child(block)
	
	world = self

static func getWorld():
	return world

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
