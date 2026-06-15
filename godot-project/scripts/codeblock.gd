class_name Codeblock extends StaticBody2D 

@onready var textBlock = $TextEdit

signal entered_pickup_range
signal exited_pickup_range

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	entered_pickup_range.connect(_on_enter_pickup_range)
	exited_pickup_range.connect(_on_exit_pickup_range)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_enter_pickup_range():
	textBlock.text = "i am in range"
	
func _on_exit_pickup_range():
	textBlock.text = "i am no longer in range"
