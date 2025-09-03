extends CharacterBody2D

@export var speed := 150
@export var run_speed := 250
var direction := Vector2.ZERO

@export var jump_strength := 300
@export var up_gravity := 450
@export var fall_gravity := 700
@export var terminal_velocity := 300
var jump := false
var gravity_multiplier := 1

@export var walking: bool = false

func _physics_process(delta):
	update_status(delta)
	handle_input()
	apply_movement()
	update_display()
	
func update_status(delta):
	if not is_on_floor():
		apply_gravity(delta)
 
func handle_input():
	var mvmt_dir = Input.get_axis("left", "right")

	if mvmt_dir > 0.2:
		velocity.x = run_speed if Input.is_action_pressed("run") and ( is_on_floor() or $Timers/LedgeJump.time_left ) else speed
		walking = true
	elif mvmt_dir < -0.2:
		velocity.x = -run_speed if Input.is_action_pressed("run") and ( is_on_floor() or $Timers/LedgeJump.time_left ) else -speed
		walking = true
	else:
		walking = false
		velocity.x = 0
		global_position.x = int(round(global_position.x))
			
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() or $Timers/LedgeJump.time_left:
			jump = true
			$Timers/JumpCancel.start()
		
		if velocity.y > 0 and not is_on_floor():
			$Timers/SmartJump.start()
	if Input.is_action_just_pressed("fall_blocks"):
		Globals.fall_blocks.emit()

func apply_movement():
		
	if jump or $Timers/SmartJump.time_left and is_on_floor():
		velocity.y = -jump_strength
		jump = false
		if $Timers/SmartJump.time_left and is_on_floor():
			$Timers/JumpCancel.start()
		
	if (Input.is_action_just_released("jump") or not Input.is_action_pressed("jump")) and $Timers/JumpCancel.time_left:
		velocity.y = max(velocity.y, 0)
		
	var floor_before_move := is_on_floor()
	move_and_slide()
	if floor_before_move and not is_on_floor() and velocity.y >= 0:
		$Timers/LedgeJump.start()

func update_display():
	if walking and velocity.x > 0:
		$Sprite2D.flip_h = false
		$HitBox.scale.x = 1
	elif walking and velocity.x < 0:
		$Sprite2D.flip_h = true
		$HitBox.scale.x = -1

func get_grav():
	return up_gravity if velocity.y < 0 else fall_gravity

func apply_gravity(delta):
	velocity.y += get_grav() * delta
	velocity.y = velocity.y * gravity_multiplier
	velocity.y = min(velocity.y, terminal_velocity)
