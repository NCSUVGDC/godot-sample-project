extends RigidBody2D

@export_range(0, 3.0) var time_to_fall: float
var starting_location: Vector2
var starting_modulate: Color

func _ready():
	freeze = true
	$FallTimer.wait_time = time_to_fall
	starting_location = global_position
	starting_modulate = modulate
	
func reset():
	modulate = starting_modulate
	freeze = true
	global_position = starting_location

func _on_fall_timer_timeout():
	freeze = false
	$DespawnTimer.start()

func _on_despawn_timer_timeout():
	reset()


func _on_step_detector_body_entered(body):
	if "is_on_floor" in body and body.is_on_floor() and not $FallTimer.time_left:
		$FallTimer.start()
		modulate += Color("#4f0000")
