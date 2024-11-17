extends Area2D

var player: CharacterBody2D
var speed: float = 10
var owner_name: String = ""
var direction: Vector2 = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node("../Player")

func move(delta):
	if (owner_name == "kev"):
		if is_instance_valid(player):
			if (!player.isKicking):
				print(player.isKicking)
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
			
		
func _physics_process(delta: float) -> void:
	move(delta)
	if (Input.is_action_pressed("switch")):
		owner_name = ""


func _on_body_entered(body: Node2D) -> void:
	if owner_name == "":
		owner_name = "kev"
