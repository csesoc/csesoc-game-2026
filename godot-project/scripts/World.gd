# world.gd
class_name World
extends Node2D

@export var playerScene: PackedScene
@export var blockScene: PackedScene

var players: Array[Player] = []
var blocks: Array[Codeblock] = []
static var world

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	## add player
	#var player = playerScene.instantiate()
	#players.append(player)
	#add_child(player)
	
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
