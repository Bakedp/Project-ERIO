extends KinematicBody2D

const SPEED = 5 * 96 #96 è la tile size
const GRAVITY = 1500
const JUMP_POWER = -400
const FLOOR = Vector2(0, -1)

var velocity = Vector2()
var on_ground = false
var jump_count = 0

func _physics_process(delta):

	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
	else:
		velocity.x = 0

	if Input.is_action_just_pressed("ui_up") && jump_count < 2:
		jump_count += 1
		velocity.y = JUMP_POWER
		on_ground = false

	velocity.y += delta * GRAVITY
	velocity = move_and_slide(velocity, FLOOR)

	if is_on_floor():
		if on_ground == false:
			on_ground = true
			jump_count = 0
	else:
		if on_ground == true:
			on_ground = false
			jump_count = 1
