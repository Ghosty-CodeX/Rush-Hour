extends CharacterBody3D

@export var swerve_distance: float = 3.0  # How far to swerve
@export var swerve_speed: float = 2.0     # How fast the car swerves
@export var swerve_trigger_distance: float = 15.0  # Distance from player to trigger swerve
@export var swerve_chance:= 0.3

var player: Node3D              # Set by road_tile.gd when spawning
var can_swerve: bool = true     # Set false if cars are side-by-side
var has_swerved:= false   # To ensure car swerves only once
var swerve_checked:= false

var swerve_direction := 0
var start_position := Vector3.ZERO
var target_position := Vector3.ZERO



func _ready():
	randomize()

	if not can_swerve:
		return
	if player == null:
		return
	
	start_position = global_position

	# Determine direction based on X position
	if is_equal_approx(global_position.x, 0.0):
		swerve_direction = -1 if randf() < 0.5 else 1
	elif global_position.x < 0.0:
		swerve_direction = 1
	else:
		swerve_direction = -1

	target_position = global_position + Vector3(swerve_direction * swerve_distance, 0, 0)




func _physics_process(delta):
	if player and not has_swerved and can_swerve and not swerve_checked:
		var distance_to_player = global_position.distance_to(player.global_position)
		if distance_to_player < swerve_trigger_distance:
			swerve_checked = true  # Don't re-check next frame

			if randf() < swerve_chance:
				has_swerved = true
				swerve_direction = 1 if global_position.x < 0.0 else -1
				target_position = global_position + Vector3(swerve_direction * swerve_distance, 0, 0)
				print("Swerve triggered!")
			else:
				print("Decided not to swerve.")

	if has_swerved:
		global_position.x = move_toward(global_position.x, target_position.x, swerve_speed * delta)
