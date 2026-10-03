class_name CodeblockIf
extends Codeblock

static var scene = preload("res://worldspace/interactables/codeblocks/CodeblockIf.tscn")

# if condition
var condition: ExpressionNode = null # (int, string, or other)
# the variable to be assigned the value
var body: Array[Codeblock] = []

static func create():
	var instance = scene.instantiate()
	return instance

func runCode(interpreter: Interpreter):
	if condition.evaluateBoolean():
		interpreter.run_program(body)

	interpreter.steps += 1
	
