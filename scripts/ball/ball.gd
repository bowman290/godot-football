extends Area2D

var player: CharacterBody2D
var speed: float = 10
var owner_name: String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node("../Player")

func move(delta):

	if (owner_name == "kev"):
		if is_instance_valid(player):
			
			var offset: Vector2 = player.position
			offset.y += 1;
			if (player.movementDirection == "up"):
				offset.y -= 4;
			elif (player.movementDirection == "right"):
				offset.x += 6;
			elif (player.movementDirection == "down"):
				offset.y += 4;
			elif (player.movementDirection == "left"):
				offset.x -= 6;
			else:
				offset.x += 6;
			
			self.position = offset
		

func _physics_process(delta: float) -> void:
	move(delta)


func _on_body_entered(body: Node2D) -> void:
	if owner_name == "":
		owner_name = "kev"
