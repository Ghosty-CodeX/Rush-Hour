extends Node3D

@export var obstacle_scene: PackedScene
@export var spawn_chance: float = 0.5 #Set the spawn chance of an obsticle current 50%

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func spawn_obstacle():
	if obstacle_scene == null:
		print("Obstacle scene not assigned")
		return
	
	var spawn_points = $SpawnPoints.get_children()
	if spawn_points.size() == 0:
		print("No spawn points found")
	
	var random_spawn = spawn_points[randi() % spawn_points.size()]
	var obstacle = obstacle_scene.instantiate()
	obstacle.position = random_spawn.position
	add_child(obstacle)
