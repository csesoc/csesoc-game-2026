# ExpressionValue.gd
class_name ExpressionValue
extends ExpressionNode

static var scene = load("res://worldspace/interactables/expressions/ExpressionValue.tscn")

# value of the expression
var value

static func create(value):
	var instance = scene.instantiate()
	instance.value = value
	return instance

func evaluate():
	return value
	
func evaluateString():
	return str(value)
	
func evaluateBoolean():
	return true
	
