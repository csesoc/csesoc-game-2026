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
	print("=== Testing print block ===\n")
	
	# Test 1: print a single number
	var program1 = [
		{ "type": "print", "value": 42 }
	]
	run_program(program1)
	var expected1 = [42]
	if output == expected1:
		print("✓ Test 1 PASS: print single number")
	else:
		print("✗ Test 1 FAIL: got ", output, " expected ", expected1)
	
	# Test 2: print multiple numbers
	var program2 = [
		{ "type": "print", "value": 1 },
		{ "type": "print", "value": 2 },
		{ "type": "print", "value": 3 }
	]
	run_program(program2)
	var expected2 = [1, 2, 3]
	if output == expected2:
		print("✓ Test 2 PASS: print multiple numbers")
	else:
		print("✗ Test 2 FAIL: got ", output, " expected ", expected2)
	
	# Test 3: print a string
	var program3 = [
		{ "type": "print", "value": "hello" }
	]
	run_program(program3)
	var expected3 = ["hello"]
	if output == expected3:
		print("✓ Test 3 PASS: print string")
	else:
		print("✗ Test 3 FAIL: got ", output, " expected ", expected3)
	
	print("\n=== All tests for print block complete ===")