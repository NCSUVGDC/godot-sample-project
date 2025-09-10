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


# Variables
var a = 5
var s = "Hello"
var array = [1, 2, 3]
var dictionary = {"key": "value", 2: "two"}
var dictionary_value = dictionary["key"]
var typed_variable : int
var inferred_type := "String"

# Constant
const ANSWER = 42

# Enumerations
enum {UNIT_NEUTRAL, UNIT_ENEMY, UNIT_ALLY}
enum Named {THING_1, THING_2, ANOTHER_THING = -1}
var enum_val : Named = Named.THING_1

# Vectors
var v2 = Vector2(1, 2)
var v3 = Vector3(1, 2, 3)

# Use variables to store scenes, nodes, resources, etc as needed
var pck_scn : PackedScene
var nd_2d : Node2D
var character_data: Resource

# Export variables - Click the node this script is attached to
# and look at the inspector on the right.
@export_category("Control this in the editor")
@export var true_or_false : bool
@export var exp_int : int
@export var exp_str : String
@export_range(0, 10.0) var range : float
@export var exp_pck : PackedScene

# This method is called when the node and its children enter the scene tree
func _ready():
	some_function(0, 2, 3)

# Check output to see what I do when the platformer scene begins
func some_function(param1, param2, param3):
	const local_const = 5
	var smth := Something.new()
	var smtha = smth.a
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
	print(RandomNumberGenerator.new().randi_range(1, 100))
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
