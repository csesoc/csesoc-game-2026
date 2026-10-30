# ExpressionNode.gd
@abstract
class_name ExpressionNode
extends Interactable

@onready var textBlock = $TextEdit
@onready var pickupComponent: PlayerPickupComponent = $PlayerPickupComponent

# static var scene = preload("res://worldspace/interactables/codeblocks/CodeblockAssign.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

@abstract func evaluate()
@abstract func evaluateString()
@abstract func evaluateBoolean()

func onPlayerInteract(player: Player):
	if pickupComponent.isPlayerAttached():
		pickupComponent.getDropped(player)
	else:
		pickupComponent.getPickedUp(player)
