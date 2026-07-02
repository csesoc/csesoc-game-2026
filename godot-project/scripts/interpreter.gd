extends Node

# Interpreter state
var variables = {}
var output = []

func reset():
	variables = {}
	output = []

func run_program(program):
	reset()
	for statement in program:
		run(statement)

func run(node):
	var block_type = node.get("type")
	if block_type == null:
		output.append("ERROR: block has no type")
		return

	match block_type:
		"print":
			var value = node.get("value")
			if value == null:
				output.append("ERROR: print block missing value")
				return
			output.append(evaluate(value))
        
        # TODO: other block types

func evaluate(value):
	# TODO: handle variables, math expressions, and comparisons
	return value