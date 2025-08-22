extends CharacterBody2D

var speed: int
@export var walk_speed: int = 20
@export var run_speed: int = 50
@export var health: int = 50

var player_name: String = "kev"

var movementDirection: String = ""
var item: String
var dying: bool = false;
var isKicking: bool = false;
var ball: RigidBody2D;
var kickHoldingTime = 0;

var can_interact = false

@onready var _animated_sprite = $AnimatedSprite2D
@onready var _target = $Target

signal capturedBall
signal releasedBall

func _ready() -> void:
	ball = get_node("../Ball")
	
func checkRunInput():
	if Input.is_action_pressed("run"):
		_animated_sprite.speed_scale = 3
		speed = run_speed
	else:
		_animated_sprite.speed_scale = 1
		speed = walk_speed
			
func checkKickInput():
	# check if kicking the ball
	if Input.is_action_pressed("kick") and !isKicking:
		if (kickHoldingTime < 100):
			kickHoldingTime += 1
			print(kickHoldingTime)
	else:
		kickHoldingTime = 0
	
func check_movement():
   # We create a local variable to store the input direction.
	var direction = Vector2.ZERO;

	# We check for each move input and update the direction accordingly.
	if Input.is_action_pressed("right"):
		_animated_sprite.flip_h = false
		$Shadow.flip_h = false
		_animated_sprite.play("runRight")
		direction.x += 1
		movementDirection = "right"
		$InteractArea.position = Vector2(10, 0)
	elif Input.is_action_pressed("left"):
		_animated_sprite.flip_h = false
		$Shadow.flip_h = false
		_animated_sprite.play("runLeft")
		direction.x -= 1
		movementDirection = "left"
		$InteractArea.position = Vector2(-10, 0)
	elif Input.is_action_pressed("down"):
		_animated_sprite.play("runDown")
		direction.y += 1
		movementDirection = "down"
		$InteractArea.position = Vector2(0, 10)
	elif Input.is_action_pressed("up"):
		_animated_sprite.play("runUp")
		direction.y -= 1
		movementDirection = "up"
		$InteractArea.position = Vector2(0, -10)
	else:
		_animated_sprite.play("idle")
		if (movementDirection == "left"):
			_animated_sprite.flip_h = true
			$Shadow.flip_h = true

	# if running
	checkRunInput();
	
	# create movement velocity
	velocity = direction * speed

func _physics_process(delta: float):
	#_target.look_at(get_global_mouse_position())
	check_movement()
	checkKickInput()
	move_and_slide()
	
	if Input.is_action_pressed("interact") && can_interact:
		#print(can_interact)
		capturedBall.emit()
	
	if Input.is_action_just_pressed("switch"):
		releasedBall.emit()
		

func _on_kick_timer_timeout() -> void:
	pass

func _on_interact_area_body_entered(body: Node2D) -> void:
	print('yup')
	if body.is_in_group("interactable"):
		can_interact = true

func _on_interact_area_body_exited(body: Node2D) -> void:
	can_interact = false
	
