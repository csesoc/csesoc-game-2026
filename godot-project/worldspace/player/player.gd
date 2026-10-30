class_name Player
extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var interaction_hitbox = $InteractionArea

@export var speed: float = 100
var facingDirection: Vector2 # the last facing direction

const HITBOX_DIST: int = 8

var heldObject

# player interactable 
var interactablesInRange: Array[Interactable] = [];

signal pickupObject(object)
signal dropObject(object)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interaction_hitbox.body_entered.connect(_on_interaction_enter)
	interaction_hitbox.body_exited.connect(_on_interaction_exit)
	pickupObject.connect(onPickupObject)
	dropObject.connect(onDropObject)

func _physics_process(delta: float) -> void:
	var direction = getDirection()
	velocity = direction * speed
	
	move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if velocity.length() > 0:
		animated_sprite.play("walk")
	else:
		animated_sprite.play("idle")

	# set facing direction
	var direction = getDirection()
	if direction != Vector2(0, 0):
		interaction_hitbox.position = HITBOX_DIST * direction
		interaction_hitbox.rotation = getRotation() + PI / 2
		facingDirection = direction

func _on_interaction_enter(body: Node2D):
	if body is not Interactable:
		return
	
	body.enteredTnteractRange.emit()
	interactablesInRange.append(body)

func _on_interaction_exit(body: Node2D):
	if body is not Interactable:
		return
	
	body.exitedInteractRange.emit()
	interactablesInRange.erase(body)

# input handler
func _input(event: InputEvent):
	if event.is_action_pressed("primary interact"):
		print("player tried to interact")
		if heldObject != null:
			print("while already holding object")
			heldObject.playerInteract.emit(self)
			return
		
		# TODO | sort by range
		for interactable in interactablesInRange:
			interactable.playerInteract.emit(self)
			break
			
func onPickupObject(object: Node2D):
	object.position = Vector2(0, -20)
	add_child(object)
	heldObject = object
	speed = 90

func onDropObject(object):
	remove_child(object)
	object.position = position + facingDirection * 100
	heldObject = null
	speed = 100

# HELPERS
# =============================================================================
# helper function to get the direction of the player input
func getDirection() -> Vector2:
	var direction = Vector2(0, 0)
	if Input.is_action_pressed("move left"):
		direction += Vector2(-1, 0)
	if Input.is_action_pressed("move right"):
		direction += Vector2(1, 0)
	if Input.is_action_pressed("move up"):
		direction += Vector2(0, -1)
	if Input.is_action_pressed("move down"):
		direction += Vector2(0, 1)
	
	direction = direction.normalized();
	return direction;
		
func getRotation() -> float:
	var direction = getDirection()
	return direction.angle()
