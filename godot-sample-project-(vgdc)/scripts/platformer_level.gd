extends Node2D

# Preloads the t_block as a packed scene
var t_block : PackedScene = preload("res://scenes/t_block.tscn")

# Connects the create_block scene to the place_block function
func _ready():
	Globals.create_block.connect(do_nothing)
	
# Does nothing lol
func do_nothing():
	pass

# Places a block wherever your mouse is positioned
func place_block():
	var new_block = t_block.instantiate()
	$Objects/T_Blocks.add_child(new_block)
	new_block.global_position = get_global_mouse_position()
