# Interactable.gd
@abstract
class_name Interactable
extends Node2D

signal enteredTnteractRange
signal exitedInteractRange
signal playerInteract(player: Player)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    enteredTnteractRange.connect(onEnterInteractRange)
    exitedInteractRange.connect(onExitInteractRange)
    playerInteract.connect(onPlayerInteract)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

@abstract func onPlayerInteract(player: Player)
func onEnterInteractRange():
    pass

func onExitInteractRange():
    pass
