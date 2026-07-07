# csesoc-game-2026
## logs
- 10/06/26 -> subcommittee has started working on it yay
- 11/06/26 -> started filling documentation for the code execution engine
- 01/07/26 -> created the skeleton of the interpreter and made a prototype of a print block

## code execution
### overview
player arranges blocks (visual nodes) 
--> conversion --> intermediate representation (IR): Godot object
--> interpreter reads the IR and executes the code --> stores output
--> test runner compares the output to expected output --> returns PASS/FAIL

### intermediate representation
stores programs as an array of statements, each statement being represented as a dictionary. two types of statements:
- run (action being executed)
- evaluate (math expression or true/false condition)

#### block prototypes
##### printing
printing a literal (e.g. the integer 42):
```gdscript
    {
        "type": "print",
        "value": 42
    }
```

printing a variable:
```gdscript
    {
        "type": "print",
        "value": {
            "type": "variable",
            "name": "i"
        }
    }
```

printing an expression
```gdscript
    {
        "type": "print"
        "value": {
            "type": "math",
            "operation": "+",
            "left": {
                "type": "variable",
                "name": "i"
            },
            "right": "5"
        }
    }
```

if statement
```gdscript
    {
        "type": "if",
        "condition": {
            "type": "compare",
            "operation": "==",
            "left": {
                "type": "variable:,
                "name": "i"
            },
            "right": 5
        },
        "body": [
            {"type": "print", "value": 100}
        ]
    }
```

if/else statement
```gdscript
    {
        "type": "if",
        "condition": {
            "type": "compare",
            "operation": "==",
            "left": {
                "type": "variable:,
                "name": "i"
            },
            "right": 5
        },
        "body": [
            {"type": "print", "value": 100}
        ],
        "else": [
            {"type": "print", "value": 0}
        ]
    }
```

if/else/else-if
```gdscript
    {
        "type": "if",
        "condition": {
            "type": "compare",
            "operation": "==",
            "left": {
                "type": "variable",
                "name": "i"
            },
            "right": 5
        },
        "body": [
            {"type": "print", "value": 100}
        ],
        "else": {
            "type": "if",
            "condition": {
                "type": "compare",
                "operation": "==",
                "left": {
                    "type": "variable:,
                    "name": "i"
                },
                "right": 5
            },
            "body": [
                {"type": "print", "value": 100}
            ],
            "else": [
                {"type": "print", "value": 0}
            ]
        }
    }
```

TODO (run): set a variable, for/while, if/else/else-if
TODO (eval): literal, variable, math, compare

### interpreter
#### core state
- variables: a dict"ionary of variables mapping name to value
- output: an array storing everything printed by the program, in order
- steps: the number of operations that have been run
- step limit: the maximum number of allowable operations

#### core functions
- reset(): resets all variables so that the state of the last test case does not leak and influence the state of the next
- run(node): executes one statement by looking at node["type"] and performing that action. calls itself on each 'child' (each element in node["body"] to allow nesting)
- evaluate(value): returns a value given an expression. if the value is a number or string, return it as is. otherwise, either a math operation or a comparison will be passed in, so the function will either evaluate the operation or return true/false, respectively

### testing
note: should handle failures gracefully (i.e. infinite loops, division by 0, etc... should not cause the game to crash)

#### core functions
- run_program(program): runs a whole program (a list of statements, stored as an array of dictionaries)
- run_test(program, expected): execute the program through the interpreter, and returns true if the output matches what was expected

could batch tests, but then a new function is needed:
```gdscript
tests = [
    {
        "program": [],
        "expected": []
    }
]
```
- run_tests(tests): calls run_test on all tests given in array "tests", and returns true if all tests pass

### converter
converts visual code blocks into Godot objects for the interpreter. will catch syntax errors (functions as a compiler). need to communicate with tilemap team to work out:
- how does a node communicate what type of block it is?
- where to find the node's filled-in values
- how is nesting represented