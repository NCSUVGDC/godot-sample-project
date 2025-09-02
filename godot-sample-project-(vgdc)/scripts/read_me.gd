extends Node

# Welcome to the Video Game Development Club @ NCSU Godot Sample Project

# This project will cover the basic of the engine's various features,
# such as nodes, signals, and the scripting language GDScript.

# To start here's a modified/annotated version of the GDScript reference

# Every .gd script file is itself a class, meaning it is like a blueprint for an object.
# An object is essentially an item kept in memory defined by things like variables and methods.

# That class can be named if you want. ( This is especially useful for classes
# that get referenced a lot. )
class_name MyClass

# If you want the class 
# extends BaseClass


# Member variables.
var a = 5
var s = "Hello"
var arr = [1, 2, 3]
var dict = {"key": "value", 2: 3}
var other_dict = {key = "value", other_key = 2}
var typed_var: int
var inferred_type := "String"

# Constants.
const ANSWER = 42
const THE_NAME = "Charly"

# Enums.
enum {UNIT_NEUTRAL, UNIT_ENEMY, UNIT_ALLY}
enum Named {THING_1, THING_2, ANOTHER_THING = -1}

# Built-in vector types.
var v2 = Vector2(1, 2)
var v3 = Vector3(1, 2, 3)


# Functions.
func some_function(param1, param2, param3):
	const local_const = 5

	if param1 < local_const:
		print(param1)
	elif param2 > 5:
		print(param2)
	else:
		print("Fail!")

	for i in range(20):
		print(i)

	while param2 != 0:
		param2 -= 1

	match param3:
		3:
			print("param3 is 3!")
		_:
			print("param3 is not 3!")

	var local_var = param1 + 3
	return local_var


# Functions override functions with the same name on the base/super class.
# If you still want to call them, use "super":
#func something(p1, p2):
	#super(p1, p2)


# It's also possible to call another function in the super class:
#func other_something(p1, p2):
	#super.something(p1, p2)


# Inner class
class Something:
	var a = 10
