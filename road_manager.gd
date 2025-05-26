extends Node3D

@export var road_tile_scene: PackedScene
@export var environment_tile_scene: Array[PackedScene] = []
@export var player_path: NodePath
@export var game_over_ui_path: NodePath
@export var tile_length: float = 10.0
@export var tiles_ahead: int = 5
@export var max_tiles: int = 10

var spawned_tiles: Array[Node3D] = []
var player: Node3D
var game_over_ui: Node
var last_tile_z: float = 0.0

func _ready():
	player = get_node(player_path)
	game_over_ui = get_node(game_over_ui_path)
	
	for i in range(tiles_ahead):
		spawn_tile(i * tile_length)

func _process(_delta):
	if player == null:
		return
	
	var player_z = player.global_position.z

	while player_z + (tiles_ahead * tile_length) > last_tile_z:
		spawn_tile(last_tile_z + tile_length)

	while spawned_tiles.size() > max_tiles:
		var old_tile = spawned_tiles.pop_front()
		if is_instance_valid(old_tile):
			old_tile.queue_free()



func spawn_tile(z_position: float):
	var tile = road_tile_scene.instantiate()
	tile.position = Vector3(0, 0, z_position)
	add_child(tile)
	
	spawned_tiles.append(tile)
	last_tile_z = z_position
	
	# Pass player and game over UI references
	if tile.has_method("spawn_obstacle"):
		tile.game_over_ui = game_over_ui
		tile.spawn_obstacle(player)
	
	if environment_tile_scene:
		if environment_tile_scene.size() == 0:
			return
		
		var scene = environment_tile_scene.pick_random()
		var env_tile = scene.instantiate()
		
		env_tile.position.z = z_position
		add_child(env_tile)
		#var env_tile = environment_tile_scene.instantiate()
		#env_tile.position = Vector3(0, 0, z_position)
		#add_child(env_tile)
		#print("Environment tile spawned at z=", z_position)
