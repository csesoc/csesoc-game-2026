# ExpressionNode.gd
@abstract
class_name ExpressionNode
extends Interactable

@onready var textBlock = $TextEdit
@onready var pickupComponent: PlayerPickupComponent = $PlayerPickupComponent
@onready var collisionShape: CollisionShape2D = $CollisionShape2D


# static var scene = preload("res://worldspace/interactables/codeblocks/CodeblockAssign.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

@abstract
func evaluate()


@abstract func runCode(interpreter: Interpreter) -> void

# pickup functionality
func onPickup():
	scale /= 2
	collisionShape.call_deferred("disabled", true)
	
func onDrop():
	scale *= 2
	collisionShape.call_deferred("disabled", false)

func onPlayerInteract(player: Player):
	if pickupComponent.isPlayerAttached():
		pickupComponent.getDropped(player)
	else:
		pickupComponent.getPickedUp(player)
