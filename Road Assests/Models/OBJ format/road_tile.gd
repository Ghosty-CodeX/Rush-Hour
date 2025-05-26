extends Node3D

@export var obstacle_scene: Array[PackedScene] = []
@onready var lane_left = $SpawnPoints/LaneLeft
@onready var lane_right = $SpawnPoints/LaneRight
@export var left_lane_spawn_chance := 40
@export var right_lane_spawn_chance := 40

var game_over_ui: Node = null

func spawn_obstacle(player):
	var should_spawn_left = randi() % 100 < left_lane_spawn_chance
	var should_spawn_right = randi() % 100 < right_lane_spawn_chance

	var both_lanes = should_spawn_left and should_spawn_right

	if should_spawn_left:
		var scene = obstacle_scene.pick_random()
		var obstacle_left = scene.instantiate()
		obstacle_left.position = lane_left.position
		obstacle_left.player = player  
		obstacle_left.can_swerve = not both_lanes
		obstacle_left.player_crashed.connect(_on_player_crashed)
		add_child(obstacle_left)

	if should_spawn_right:
		var scene = obstacle_scene.pick_random()
		var obstacle_right = scene.instantiate()
		obstacle_right.position = lane_right.position
		obstacle_right.player = player
		obstacle_right.can_swerve = not both_lanes
		obstacle_right.player_crashed.connect(_on_player_crashed)
		add_child(obstacle_right)

func _on_player_crashed():
	if game_over_ui:
		game_over_ui.show_game_over()
		get_tree().paused = true
	else:
		print("⚠️ game_over_ui is null!")
