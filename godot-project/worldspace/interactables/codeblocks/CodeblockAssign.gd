class_name CodeblockAssign
extends Codeblock

static var scene = preload("res://worldspace/interactables/codeblocks/CodeblockAssign.tscn")

# the value to assign
var value: ExpressionNode = null # : ExpressionNode = null # (int, string, or other)
# the variable to be assigned the value
var target: String

static func create(target: String):
	var instance = scene.instantiate()
	instance.target = target
	return instance
	
# return self to allow method chaining hehehhehe
func attach(value: ExpressionNode):
	self.value = value
	return self

func runCode(interpreter: Interpreter):
	interpreter.variables[target] = value.evaluate()
	interpreter.steps += 1
	
