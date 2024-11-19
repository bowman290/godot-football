extends Area2D

var player: CharacterBody2D
var speed: float = 40
var owner_name: String = ""
var direction: Vector2 = Vector2(0, 0)

var ballKicked = false
var traveledDistance: float = float()
var startPosition: Vector2 = Vector2(0, 0)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node("../Player")

func move():
	if (owner_name != ""):
		if is_instance_valid(player):
			if (!ballKicked):
				var offset: Vector2 = player.global_position
				offset.y += 2;
				if (player.movementDirection == "up"):
					offset.y -= 6;
					self.z_index = 1;
				elif (player.movementDirection == "right"):
					offset.x += 5;
				elif (player.movementDirection == "down"):
					offset.y += 3;
				elif (player.movementDirection == "left"):
					offset.x -= 5;
				else:
					offset.x += 6;
				self.global_position = offset

func kickCheck(delta):
	if (ballKicked):
		if traveledDistance < 20:
			owner_name = ""
			self.position += direction * speed * delta
			traveledDistance = self.position.distance_to(startPosition)
		else:
			traveledDistance = 0
			ballKicked = false
		
func _physics_process(delta: float) -> void:
	move()
	kickCheck(delta)
	if (Input.is_action_pressed("switch")):
		owner_name = ""

func _on_body_entered(body: Node2D) -> void:
	if owner_name == "":
		ballKicked = false
		owner_name = body.player_name
