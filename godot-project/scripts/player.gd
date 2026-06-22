class_name Player
extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var interaction_hitbox = $Area2D

@export var speed: float = 100
var facingDirection: Vector2
var facingRotation: float
@export var HITBOX_DIST: int = 8

var heldObject

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
	var direction = get_direction()
	velocity = direction * speed
	
	move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if velocity.length() > 0:
		animated_sprite.play("walk")
	else:
		animated_sprite.play("idle")

	interaction_hitbox.position = HITBOX_DIST * facingDirection
	interaction_hitbox.rotation = facingRotation

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
	if event.is_action_pressed("move left"):
		facingDirection = Vector2(-1, 0)
		facingRotation = deg_to_rad(-90)
		
	if event.is_action_pressed("move right"):
		facingDirection = Vector2(1, 0)
		facingRotation = deg_to_rad(90)
		
	if event.is_action_pressed("move up"):
		facingDirection = Vector2(0, -1)
		facingRotation = deg_to_rad(180)
		
	if event.is_action_pressed("move down"):
		facingDirection = Vector2(0, 1)
		facingRotation = deg_to_rad(0)
		
	if event.is_action_pressed("primary interact"):
		if heldObject != null:
			heldObject.playerInteract.emit(self)
			return
		
		for interactable in interactablesInRange:
			interactable.playerInteract.emit(self)
			
func onPickupObject(object: Node2D):
	object.position = Vector2(0, -20)
	add_child(object)
	heldObject = object

func onDropObject(object):
	remove_child(object)
	object.position = position + facingDirection * HITBOX_DIST
	heldObject = null

# HELPERS
# =============================================================================
# helper function to get the direction of the player input
func get_direction() -> Vector2:
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
	#print(direction)
	#print(position)
	return direction;
		
