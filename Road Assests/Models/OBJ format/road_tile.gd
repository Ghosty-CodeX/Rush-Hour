extends Node3D

@export var obstacle_scene: PackedScene
@export var spawn_chance: float = 0.5 #Set the spawn chance of an obsticle current 30%
@onready var lane_left = $SpawnPoints/LaneLeft
@onready var lane_right = $SpawnPoints/LaneRight

# Called when the node enters the scene tree for the first time.
func spawn_obstacle(player):
	var should_spawn_left = randi() % 100 < 50
	var should_spawn_right = randi() % 100 < 50

	var both_lanes = should_spawn_left and should_spawn_right

	if should_spawn_left:
		var obstacle_left = obstacle_scene.instantiate()
		obstacle_left.position = lane_left.position
		obstacle_left.player = player  
		obstacle_left.can_swerve = not both_lanes
		add_child(obstacle_left)

	if should_spawn_right:
		var obstacle_right = obstacle_scene.instantiate()
		obstacle_right.position = lane_right.position
		obstacle_right.player = player
		obstacle_right.can_swerve = not both_lanes
		add_child(obstacle_right)
