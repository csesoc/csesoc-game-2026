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

		"if":
			var condition = node.get("condition")
			if condition == null:
				output.append("ERROR: if block missing condition")
				return

			if evaluate(condition):
				for statement in node.get("body", []):
					run(statement)

			else:
				var else_branch = node.get("else")
				if else_branch == null:
					return
				if else_branch is Array:
					for statement in else_branch:
						run(statement)
				else: 
					run(else_branch)

# Takes in a condition 
# Update README.md to show an example of compound conditional statements
func evaluate(value):
	# comparisons
	if not (value is Dictionary):
		return value

	var value_type = value.get("type")

	match value_type:
		"variable":
			var var_name = value.get("name")
			if var_name == null:
				output.append("ERROR: variable block missing name")
				return null
			if not variables.has(var_name):
				output.append("ERROR: undefined variable '%s'" % var_name)
				return null
			return variables[var_name]

		"math":
			var operation = value.get("operation")
			if operation == null:
				output.append("ERROR: math block missing operation")
				return null

			var left = evaluate(value.get("left"))
			var right = evaluate(value.get("right"))

			match operation:
				"+":
					return left + right
				"-":
					return left - right
				"*":
					return left * right
				"/":
					if right == 0:
						output.append("ERROR: division by zero")
						return null
					return left / right
				_:
					output.append("ERROR: unknown math operation '%s'" % operation)
					return null

		_:
			output.append("ERROR: unknown evaluate type '%s'" % str(value_type))
		"compare":
			var operation = value.get("operation")
			if operation == null:
				output.append("ERROR: compare block missing operation")
				return null
			var left = evaluate(value.get("left"))
			var right = evaluate(value.get("right"))
			if left == null or right == null:
				return null
			match operation:
				">": return left > right
				"<": return left < right
				">=": return left >= right
				"<=": return left <= right
				"==": return left == right
				"!=": return left != right
				_:
					output.append("ERROR: unknown comparison '%s'" % operation)
					return null
		"logic":
			var operation = value.get("operation")
			if operation == null:
				output.append("ERROR: logic block missing operation")
				return null
			var left = evaluate(value.get("left"))
			if left == null:
				# no error message append because recursive call already did it
				return null
			if operation == "not":
				return not left
			var right = evaluate(value.get("right"))
			if right == null:
				return null
			match operation:
				"and": return left and right
				"or": return left or right
				_:
					output.append("ERROR: unknown logic operation '%s'" % operation)
					return null
			return null
