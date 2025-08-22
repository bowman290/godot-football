extends RigidBody2D

var player: CharacterBody2D

var direction: Vector2 = Vector2(0, 0)

var ballKicked: bool = false
var traveledDistance: float = 0

var owner_node: CharacterBody2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node("../Player")



func _on_player_captured_ball() -> void:
	owner_node = player
	
func _on_player_released_ball() -> void:
	owner_node = null



				
func _physics_process(delta: float) -> void:
	if owner_node:
		freeze = true
		global_position = owner_node.global_position
	else: freeze = false
		
