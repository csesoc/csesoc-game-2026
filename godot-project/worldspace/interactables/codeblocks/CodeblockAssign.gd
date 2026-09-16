class_name CodeblockAssign
extends Codeblock

static var scene = load("res://worldspace/interactables/codeblocks/CodeblockAssign.tscn")

# the value to assign
var value # (int, string, or other)
# the variable to be assigned the value
var target: String

static func create(target: String, value):
	var instance = scene.instantiate()
	instance.target = target
	instance.value = value
	return instance

func runCode(interpreter: Interpreter):
	interpreter.variables[target] = interpreter.parse(str(value))
	interpreter.steps += 1
	
