extends CharacterBody3D

signal player_crashed

@export var swerve_distance: float = 5.0  # How far to swerve
@export var swerve_speed: float = 2.0     # How fast the car swerves
@export var swerve_trigger_distance: float = 15.0  # Distance from player to trigger swerve
@export var swerve_chance:= 0.3
@onready var crash_area: Area3D = get_node("CrashArea")

var player: Node3D              # Set by road_tile.gd when spawning
var can_swerve: bool = true     # Set false if cars are side-by-side
var has_swerved:= false   # To ensure car swerves only once
var swerve_checked:= false

var swerve_direction := 0
var start_position := Vector3.ZERO
var target_position := Vector3.ZERO

func _ready():
	randomize()

	if not can_swerve or player == null:
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

	if crash_area:
		if crash_area.body_entered.is_connected(_on_crash_area_body_entered):
			crash_area.body_entered.disconnect(_on_crash_area_body_entered)
		
		crash_area.body_entered.connect(_on_crash_area_body_entered)
		print("Crash signal reconnected cleanly.")
	else:
		push_error("CrashArea not found in obstacle scene")



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

func _on_crash_area_body_entered(body):
	if body.get_name() == "player":
		print("Crash detected with player")
		emit_signal("player_crashed")
