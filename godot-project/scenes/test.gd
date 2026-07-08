class_name Test # gives a name to the class so that we can refer to the file 
# by name instead of the path
extends Node2D # Have access to all methods and fields in Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	print(position)
	position = Vector2(10,10)
	print(position)

	#var myAnimal : Animal = Animal.new("Monkey") # same as below, just to tell yourself about typing
	#var myAnimal = Animal.new("Monkey") # doesnt work when its abstracted
	var dog = Dog.new("Dog")
	var cat = Cat.new("Cat")
	
	#myAnimal.printName()
	dog.printName()
	#dog.bark()
	#myAnimal.makeNoise()
	dog.makeNoise()
	cat.makeNoise()
	cat.scratch()
	# nice 100/100
	# yippee


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
