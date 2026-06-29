# Whitebag.gd
class_name Whitebag
extends Interactable

@onready var pickupComponent: PlayerPickupComponent = $PlayerPickupComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func onPlayerInteract(player: Player):
	if pickupComponent.isPlayerAttached():
		pickupComponent.getDropped(player)
	else:
		pickupComponent.getPickedUp(player)

func onEnterInteractRange():
	#textBlock.text = "i am in range"
	pass

func onExitInteractRange():
	pass
	#textBlock.text = "i am no longer in range"
