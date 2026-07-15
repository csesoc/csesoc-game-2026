extends Node

var InterpreterScript = preload("res://scripts/interpreter.gd")
var interpreter


func _ready():
	interpreter = InterpreterScript.new()
	add_child(interpreter)

	test_set_variable()
	test_while_loop()


func test_set_variable():
	var program = [
		{
			"type": "set",
			"name": "score",
			"value": 10
		},
		{
			"type": "print",
			"value": {
				"type": "variable",
				"name": "score"
			}
		}
	]

	interpreter.run_program(program)

	assert(interpreter.output == [10])
	assert(interpreter.variables["score"] == 10)

	print("PASS: set variable")


func test_while_loop():
	var program = [
		{
			"type": "set",
			"name": "x",
			"value": 0
		},
		{
			"type": "while",
			"condition": {
				"type": "compare",
				"operation": "<",
				"left": {
					"type": "variable",
					"name": "x"
				},
				"right": 3
			},
			"body": [
				{
					"type": "print",
					"value": {
						"type": "variable",
						"name": "x"
					}
				},
				{
					"type": "set",
					"name": "x",
					"value": {
						"type": "math",
						"operation": "+",
						"left": {
							"type": "variable",
							"name": "x"
						},
						"right": 1
					}
				}
			]
		}
	]

	interpreter.run_program(program)

	assert(interpreter.output == [0, 1, 2])
	assert(interpreter.variables["x"] == 3)

	print("PASS: while loop")
