extends CharacterBody2D

# Export variables can help you find the right values
@export var speed := 200
@export var run_speed := 350
var direction := Vector2.ZERO

@export var jump_strength := 300
@export var up_gravity := 450
@export var fall_gravity := 700
@export var terminal_velocity := 300
var jump := false
var gravity_multiplier := 1

@export var walking: bool = false

# This method is called 60 times in a second
func _physics_process(delta):
	# Use methods to contain chunks of related code
	update_status(delta)
	handle_input()
	apply_movement()
	update_display()

# Before we get input, let's update their status based on where they got last frame
func update_status(delta):
	# Apply gravity if they are not grounded
	if not is_on_floor():
		apply_gravity(delta)
 
# Update status based on input this frame
func handle_input():
	# Measure the input movement direction
	var mvmt_dir = Input.get_axis("left", "right")

	# Decide if the player is doing nothing, moving left, or moving right
	if mvmt_dir > 0.2:
		# decide if the player is running and can run
		velocity.x = run_speed if Input.is_action_pressed("run") and ( is_on_floor() or $Timers/LedgeJump.time_left ) else speed
		walking = true
	elif mvmt_dir < -0.2:
		# decide if the player is running and can run
		velocity.x = -run_speed if Input.is_action_pressed("run") and ( is_on_floor() or $Timers/LedgeJump.time_left ) else -speed
		walking = true
	else:
		# stop walking
		walking = false
		velocity.x = 0

	# Check if jump has been pressed
	if Input.is_action_just_pressed("jump"):
		# Check if grounded or coyote time
		if is_on_floor() or $Timers/LedgeJump.time_left:
			jump = true
			$Timers/JumpCancel.start()
		
		# Check if falling to start smart jump timer
		if velocity.y > 0 and not is_on_floor():
			$Timers/SmartJump.start()

	# Make all falling blocks fall for comparing speed
	if Input.is_action_just_pressed("fall_blocks"):
		Globals.fall_blocks.emit()

# Apply movement stuff
func apply_movement():
	# Jump/smart jump if the buffer timer is still going
	if jump or $Timers/SmartJump.time_left and is_on_floor():
		velocity.y = -jump_strength
		jump = false
		# Start timer so you can cancel the jump
		if $Timers/SmartJump.time_left and is_on_floor():
			$Timers/JumpCancel.start()
		
	# Cancel the jump as soon as they let go
	if (Input.is_action_just_released("jump") or not Input.is_action_pressed("jump")) and $Timers/JumpCancel.time_left:
		velocity.y = max(velocity.y, 0)
		
	# store if you were grounded the frame before you move
	var floor_before_move := is_on_floor()
	# move character based on current velocities
	move_and_slide()
	# start coyote timer if you just went off a ledge
	if floor_before_move and not is_on_floor() and velocity.y >= 0:
		$Timers/LedgeJump.start()

# Handles any visual response to movement outside of animations
func update_display():
	# Flip sprite based on walking direction
	if walking and velocity.x > 0:
		$Sprite2D.flip_h = false
		$HitBox.scale.x = 1
	elif walking and velocity.x < 0:
		$Sprite2D.flip_h = true
		$HitBox.scale.x = -1
		
	# Update AnimationTree's parameters
	$AnimationTree.set("parameters/conditions/idle", not walking and is_on_floor())
	$AnimationTree.set("parameters/conditions/running", walking and is_on_floor())
	$AnimationTree.set("parameters/conditions/jumping", jump and velocity.y <= 0)
	$AnimationTree.set("parameters/conditions/falling", jump and velocity.y > 0)
	
# Get gravity
func get_grav():
	return up_gravity if velocity.y < 0 else fall_gravity

# Apply gravity
func apply_gravity(delta):
	velocity.y += get_grav() * delta
	velocity.y = velocity.y * gravity_multiplier
	velocity.y = min(velocity.y, terminal_velocity)
