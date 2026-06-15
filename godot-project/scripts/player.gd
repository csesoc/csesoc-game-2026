extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var interaction_hitbox = $Area2D

var speed: float = 60

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#position = Vector2(0, 0);
	
	# signal connects
	interaction_hitbox.body_entered.connect(_on_interaction_enter)
	interaction_hitbox.body_exited.connect(_on_interaction_exit)
	pass # Replace with function body.

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

func _on_interaction_enter(body: Node2D):
	if body is not Codeblock:
		return
	
	body.entered_pickup_range.emit()
	
func _on_interaction_exit(body: Node2D):
	if body is not Codeblock:
		return
	
	body.exited_pickup_range.emit()

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
		
