extends CharacterBody2D

var speed: int
@export var walk_speed: int = 20
@export var run_speed: int = 50
@export var health: int = 50

var movementDirection: String = ""
var item: String
var dying: bool = false;

@onready var _animated_sprite = $AnimatedSprite2D


func get_input():
   # We create a local variable to store the input direction.
	var direction = Vector2.ZERO;

	# We check for each move input and update the direction accordingly.
	if Input.is_action_pressed("right"):
		_animated_sprite.play("runRight")
		direction.x += 1
		movementDirection = "right"
	elif Input.is_action_pressed("left"):
		_animated_sprite.play("runLeft")
		direction.x -= 1
		movementDirection = "left"
	elif Input.is_action_pressed("down"):
		_animated_sprite.play("runDown")
		direction.y += 1
		movementDirection = "down"
	elif Input.is_action_pressed("up"):
		_animated_sprite.play("runUp")
		direction.y -= 1
		movementDirection = "up"
	else:
		_animated_sprite.play("idle")
		movementDirection = ""

	if Input.is_action_pressed("run"):
		_animated_sprite.speed_scale = 3
		speed = run_speed
	else:
		_animated_sprite.speed_scale = 1
		speed = walk_speed

	velocity = direction * speed

func _physics_process(_delta):
	get_input()
	move_and_slide()
