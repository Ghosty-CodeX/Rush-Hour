extends CharacterBody3D

@export var swerve_distance: float = 3.0  # How far to swerve
@export var swerve_speed: float = 2.0     # How fast the car swerves

var should_swerve := false
var swerve_direction := 0
var start_position := Vector3.ZERO
var target_position := Vector3.ZERO

func _ready():
	start_position = global_position
	# Decide randomly whether this obstacle should swerve
	should_swerve = randf() < 0.5

	if not should_swerve:
		return  # Skip swerve logic

	# Decide direction based on starting X position
	if is_equal_approx(start_position.x, 0.0):
		# Center lane (if exists), pick random direction
		swerve_direction = -1 if randf() < 0.5 else 1
	elif start_position.x < 0.0:
		# Left lane, can only swerve right (positive X)
		swerve_direction = 1
	else:
		# Right lane, can only swerve left (negative X)
		swerve_direction = -1

	# Set the swerve target position
	target_position = start_position + Vector3(swerve_direction * swerve_distance, 0, 0)

func _physics_process(delta):
	if should_swerve:
		# Smoothly move toward target swerve position
		global_position.x = move_toward(global_position.x, target_position.x, swerve_speed * delta)
