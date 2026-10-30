class_name CodeFactory
extends Interactable

@onready var textBlock = $TextEdit
@onready var pickupComponent: PlayerPickupComponent = $PlayerPickupComponent

@export var blockScene: PackedScene

func onEnterInteractRange():
	pass

func onExitInteractRange():
	pass
	
func onPlayerInteract(player: Player):
	spawnBlock(player)

func spawnBlock(player: Player):
	var block = blockScene.instantiate()
	World.getWorld().add_child(block)
	block.global_position = global_position

	var pickupComponent = block.get_node("PlayerPickupComponent")
	pickupComponent.getPickedUp(player)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
