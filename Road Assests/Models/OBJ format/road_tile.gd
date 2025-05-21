extends Node3D

@export var obstacle_scene: PackedScene
@export var spawn_chance: float = 0.5 #Set the spawn chance of an obsticle current 30%
@onready var lane_left = $SpawnPoints/LaneLeft
@onready var lane_right = $SpawnPoints/LaneRight

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	#Random chance to spawn obstacles
	var should_spawn = randi() % 100 < 30 #30% chance to spawn on obstacle
	if should_spawn:
		spawn_obstacle()


func spawn_obstacle():
	var obstacle = obstacle_scene.instantiate()
	
	#pick a random lane
	var spawn_lane = [lane_left, lane_right].pick_random()
	obstacle.position = spawn_lane.position
	add_child(obstacle)
