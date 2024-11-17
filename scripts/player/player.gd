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
var ball: Area2D;

@onready var _animated_sprite = $AnimatedSprite2D
@onready var _target = $Target

func _ready() -> void:
	ball = get_node("../Ball")

func get_input():
   # We create a local variable to store the input direction.
	var direction = Vector2.ZERO;

	# We check for each move input and update the direction accordingly.
	if Input.is_action_pressed("right"):
		_animated_sprite.flip_h = false
		$Shadow.flip_h = false
		_animated_sprite.play("runRight")
		direction.x += 1
		movementDirection = "right"
		
	elif Input.is_action_pressed("left"):
		_animated_sprite.flip_h = false
		$Shadow.flip_h = false
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
		if (movementDirection == "left"):
			_animated_sprite.flip_h = true
			$Shadow.flip_h = true

	if Input.is_action_pressed("run"):
		_animated_sprite.speed_scale = 3
		speed = run_speed
	else:
		_animated_sprite.speed_scale = 1
		speed = walk_speed

	if Input.is_action_pressed("kick") and !isKicking and ball.owner_name == player_name:
		ball.ballKicked = true
	
	velocity = direction * speed

	
#func kickBall(delta, target_pos):
#	ball.owner_name = "";
#	ball.direction = target_pos;
#	ball.position += ball.direction * ball.speed * delta
#	isKicking = false;


func _physics_process(delta: float):
	_target.look_at(get_global_mouse_position())
	get_input()
	move_and_slide()


func _on_kick_timer_timeout() -> void:
	pass
