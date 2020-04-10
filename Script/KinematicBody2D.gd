extends KinematicBody2D

const SPEED = 450
const GRAVITY = 2000
const JUMP_POWER = -700
const FASTFALL = 900
const FLOOR = Vector2(0, -1)
const MAX_JUMPS = 2

var velocity = Vector2()
var on_ground = false
var jump_count = 0

func _physics_process(delta):

	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = true
	else:
		velocity.x = 0
		if on_ground == true:
			$AnimatedSprite.play("idle")

	if Input.is_action_just_pressed("ui_up") && jump_count < MAX_JUMPS:
		jump_count += 1
		velocity.y = JUMP_POWER
		on_ground = false

	if Input.is_action_just_pressed("ui_down") && !on_ground:
		velocity.y = FASTFALL

	#if Input.is_action_just_pressed("ui_accept"):
		




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
		if velocity.y < 0:
			$AnimatedSprite.play("jump")
		else:
			$AnimatedSprite.play("fall")
