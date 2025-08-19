extends RigidBody2D

var player: CharacterBody2D
var speed: float = 10
var owner_name: String = ""
var direction: Vector2 = Vector2(0, 0)
var ballKicked: bool = false
var traveledDistance: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node("../Player")


func kickCheck(delta):
	if (ballKicked):
			owner_name = ""
			# self.rotation_degrees = rotation_degrees
			#self.position = player.get_node("Target").get_global_position()
			#self.apply_impulse(Vector2(), Vector2(speed, 0))
			ballKicked = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	kickCheck(delta)
	if (Input.is_action_pressed("switch")):
		owner_name = ""


func _on_body_entered(body: CharacterBody2D) -> void:
	print(ballKicked);
	if owner_name == "":
		owner_name = body.player_name

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if (owner_name == "kev" && ballKicked == false):
		self.sleeping = true
		if (player.movementDirection == "up"):
			
			self.transform.origin.y = player.transform.origin.y - 6;
			#self.z_index = 1;
		elif (player.movementDirection == "right"):
			
			self.transform.origin.x = player.transform.origin.x + 5;
		elif (player.movementDirection == "down"):
			
			self.transform.origin.y = player.transform.origin.y + 3;
		elif (player.movementDirection == "left"):
			
			self.transform.origin.x = player.transform.origin.x - 5;