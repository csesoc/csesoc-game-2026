class_name CodeblockAssign
extends Codeblock

static var scene = load("res://worldspace/interactables/codeblocks/CodeblockAssign.tscn")

# the value to assign
var value = 10 # : ExpressionNode = null # (int, string, or other)
# the variable to be assigned the value
var target: String

static func create(target: String):
	var instance = scene.instantiate()
	instance.target = target
	return instance

func runCode(interpreter: Interpreter):
	interpreter.variables[target] = interpreter.parse(str(value))
	interpreter.steps += 1
	
