extends CharacterBody3D

@export var move_speed: float = 15.0
@export var strafe_speed: float = 6.0
@export var road_width: float = 8.0

var input_direction: float = 0.0
var crashed = false


func _physics_process(_delta):
	#constant movemant forward
	velocity.z = move_speed
	
	
	#left and right input
	input_direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	velocity.x = -input_direction * strafe_speed
	
	#clamping the players x position to stay within the road
	var clamped_x = clamp(global_position.x, -road_width / 2, road_width / 2)
	global_position.x = clamped_x
	
	#apply movement
	move_and_slide()
