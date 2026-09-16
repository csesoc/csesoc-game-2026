class_name Player
extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var interaction_hitbox = $InteractionArea
@onready var camera: Camera2D = $Camera2D

@export var speed: float = 100
@export var facingDirection: Vector2 = Vector2(0, 1)
@export var facingRotation: float
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
	
	set_physics_process(is_multiplayer_authority())
	set_process_input(is_multiplayer_authority())
	
	camera.enabled = is_multiplayer_authority()

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
	if not is_multiplayer_authority():
		return
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
			#heldObject.playerInteract.emit(self)
			request_interaction.rpc(heldObject.get_path())
			return
		
		for interactable in interactablesInRange:
			request_interaction.rpc(interactable.get_path())
			
# all interactions are sent through rpc to sync with all players
@rpc("any_peer", "call_local", "reliable")
func request_interaction(object_path: NodePath) -> void:
	var interactable = get_node(object_path)
	interactable.playerInteract.emit(self)

#@rpc("any_peer", "call_local", "reliable")
#func request_drop(object_path: NodePath) -> void:
	#var object = get_node(object_path)
	#object.playerInteract.emit(self)
			
func onPickupObject(object: Node2D):
	object.position = Vector2(0, -20)
	add_child(object)
	heldObject = object
	speed = 50

func onDropObject(object):
	if object == null:
		return
	remove_child(object)
	object.position = position + facingDirection * 20
	heldObject = null
	speed = 100


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
		
