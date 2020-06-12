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
var atrito = 900

func Run():
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

func Jump():
	if Input.is_action_just_pressed("ui_up") && jump_count < MAX_JUMPS:
		jump_count += 1
		velocity.y = JUMP_POWER
		on_ground = false

func Ground():
	if Input.is_action_pressed("ui_down") && !on_ground: #funzione che controlla le cadute
		velocity.y = FASTFALL

func Slide():
	if Input.is_action_pressed("ui_down") and is_on_floor() and !$AnimatedSprite.flip_h:
		$AnimatedSprite.play("slide")
		#velocity.x = SPEED*2
		while atrito >= 0:
			if atrito > 0:
				atrito -= 1
				velocity.x = atrito
			else:
				break

	if Input.is_action_pressed("ui_down") and is_on_floor() and $AnimatedSprite.flip_h:
		$AnimatedSprite.play("slide")
		#velocity.x = -SPEED*2
		while atrito < 0:
			if atrito < 0:
				atrito -= 1
				velocity.x = -atrito
			else:
				break

func y_floor(): #istruzioni per quando e sul pavimento
	if on_ground == false:
		on_ground = true
		jump_count = 0

func n_floor(): #istruzioni per quando non e sul pavimento
	if on_ground == true:
		on_ground = false
		jump_count = 1
	if velocity.y < 0:
		$AnimatedSprite.play("jump")
	else:
		$AnimatedSprite.play("fall")

func Floor():
	if is_on_floor(): #controlla se sei sul pavimento
		y_floor() #istruzioni per quando e sul pavimento
	else:
		n_floor() #istruzioni per quando non e sul pavimento

func Move():
	Floor() #funzioni sul pavimento
	Jump() #funzione che controlla i salti
	Ground() #funzione che controlla le cadute
	Run() #funzione per muoversi
	Slide() #funzione per scivolare

func _physics_process(delta):
	velocity.y += delta * GRAVITY
	velocity = move_and_slide(velocity, FLOOR)
	Move()
