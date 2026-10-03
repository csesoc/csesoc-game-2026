extends Node

func _ready():
	test_set_variable()
	#test_while_loop()


func test_set_variable():
	var program: Array[Codeblock] = [
		CodeblockAssign.create("score")
		#CodeblockPrint.create("score")
	]

	Interpreter.getInstance().run_program(program)

	print(Interpreter.getInstance().output)
	#assert(Interpreter.getInstance().output == [10])
	assert(Interpreter.getInstance().variables["score"] == 10)

	print("PASS: set variable")


#func test_while_loop():
	#var program = [
		#{
			#"type": "set",
			#"name": "x",
			#"value": 0
		#},
		#{
			#"type": "while",
			#"condition": {
				#"type": "compare",
				#"operation": "<",
				#"left": {
					#"type": "variable",
					#"name": "x"
				#},
				#"right": 3
			#},
			#"body": [
				#{
					#"type": "print",
					#"value": {
						#"type": "variable",
						#"name": "x"
					#}
				#},
				#{
					#"type": "set",
					#"name": "x",
					#"value": {
						#"type": "math",
						#"operation": "+",
						#"left": {
							#"type": "variable",
							#"name": "x"
						#},
						#"right": 1
					#}
				#}
			#]
		#}
	#]
#
	#interpreter.run_program(program)
#
	#assert(interpreter.output == [0, 1, 2])
	#assert(interpreter.variables["x"] == 3)
#
	#print("PASS: while loop")
