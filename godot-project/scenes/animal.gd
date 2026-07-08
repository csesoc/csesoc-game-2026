@abstract class_name Animal
extends Node2D

var animalName

# when the object is initialised / created, this function runs
func _init(animalName):
	self.animalName = animalName 

func walk():
	print("Animal walking...")
	position += Vector2(10, 0)
		
@abstract func makeNoise()

func getPosition():
	print(position)

func printName():
	print(animalName)
