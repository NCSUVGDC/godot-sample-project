extends RigidBody2D

# Time it takes for block to start to fall
@export_range(0, 3.0) var time_to_fall: float

# Original position of block kept for reset
var starting_location: Vector2

# Original color of block kept for reset
var starting_modulate: Color

# When the block enters the scene tree set up signals and variables
func _ready():
	# This block will fall when the fall_blocks signal is emitted
	Globals.fall_blocks.connect(fall)
	# Gravity does not apply yet
	freeze = true
	# Set timer and information for reset
	$FallTimer.wait_time = time_to_fall
	starting_location = global_position
	starting_modulate = modulate

# Make the block fall
func fall():
	# Unless the block is already falling
	if not $FallTimer.time_left and not $DespawnTimer.time_left:
		# Start the timer to start falling
		$FallTimer.start()
		# Set the falling color
		modulate += Color("#1f0000")
		modulate -= Color("#000303")

# reset the block to its original state
func reset():
	modulate = starting_modulate
	freeze = true
	global_position = starting_location

# Begin the fall and despawn timer
func _on_fall_timer_timeout():
	freeze = false
	$DespawnTimer.start()

# Reset the block when it despawns
func _on_despawn_timer_timeout():
	reset()

# If a character makes contact with the block
func _on_step_detector_body_entered(body):
	if "is_on_floor" in body and body.is_on_floor():
		fall()
