# PlayerPickupComponent.gd
class_name PlayerPickupComponent
extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func getPickedUp(player: Player):
	# reparent and tell player to pick up
	var object = get_parent()
	World.getWorld().remove_child(object)
	player.pickupObject.emit(object)
	
	if object.has_method("onPickup"):
		object.onPickup()
	else:
		defaultOnPickup()
	
func getDropped(player: Player):
	var object = get_parent()
	player.dropObject.emit(object)
	World.getWorld().add_child(object)
	
	if object.has_method("onDrop"):
		object.onDrop()
	else:
		defaultOnDrop()
	
func defaultOnPickup():
	var object = get_parent()
	object.scale /= 2
	
func defaultOnDrop():
	var object = get_parent()
	object.scale *= 2
	
func isPlayerAttached():
	return get_parent().get_parent() != World.getWorld()
