class_name CodeblockPrint
extends Codeblock

static var scene = load("res://worldspace/interactables/codeblocks/CodeblockPrint.tscn")

# the value to print
var value # (int, string, or variable)

static func create(value):
	var instance = scene.instantiate()
	instance.value = value
	return instance

func runCode(interpreter: Interpreter):
	#print("printing for value/variable: ")
	#print(value)
	#print(interpreter.variables["score"])
	print("printing: ")
	print(interpreter.parse(value))
	print()
	interpreter.output.append(interpreter.parse(value))
	print(interpreter.output)
	interpreter.steps += 1
	
