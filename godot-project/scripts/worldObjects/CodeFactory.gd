class_name CodeFactory

extends Interactable

@onready var textBlock = $TextEdit
@onready var pickupComponent: PlayerPickupComponent = $PlayerPickupComponent
@onready var collisionShape: CollisionShape2D = $CollisionShape2D

func onEnterInteractRange():
	pass

func onExitInteractRange():
	pass
	
func onPickup():
	scale /= 3
	position += Vector2(0, -20)
	collisionShape.call_deferred("disabled", true)
	
func onDrop():
	scale *= 3
	position += Vector2(0, 20)
	collisionShape.call_deferred("disabled", false)

func onPlayerInteract(player: Player):
	if pickupComponent.isPlayerAttached():
		pickupComponent.getDropped(player)
	else:
		pickupComponent.getPickedUp(player)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
