# Codeblock.gd
@abstract
class_name Codeblock
extends Interactable

@onready var textBlock = $TextEdit
@onready var pickupComponent: PlayerPickupComponent = $PlayerPickupComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
@abstract func runCode(interpreter: Interpreter) -> void

# pickup functionality
func onPickup():
	pass
	
func onDrop():
	pass

func onPlayerInteract(player: Player):
	if pickupComponent.isPlayerAttached():
		pickupComponent.getDropped(player)
	else:
		pickupComponent.getPickedUp(player)
