#class_name Parser
#extends Node
#
#static func parse(value: String):
	## is a string
	#if value[0] == "\"" and value[-1] == "\"":
		#print("is string")
		#return value.substr(1, value.length() - 2)
		#
	## is a number (no integer handling yet)
	#if value[0].is_valid_float():
		#print("is float")
		#return value.to_float()
		#
	## is a variable
	#print("is var")
	#print(Interpreter.getInstance().variables)
	#return Interpreter.getInstance().variables[value]
