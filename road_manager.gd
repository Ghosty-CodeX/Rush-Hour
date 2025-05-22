extends Node3D

@export var road_tile_scene: PackedScene
@export var player_path: NodePath
@export var tile_length: float = 10.0
@export var tiles_ahead: int = 5
@export var max_tiles: int = 10

var spawned_tiles: Array[Node3D] = []
var player: Node3D
var last_tile_z: float = 0.0

func _ready():
	player = get_node(player_path)
	
	# Spawn initial road tiles
	for i in range(tiles_ahead):
		spawn_tile(i * tile_length)

func _process(delta):
	if player == null:
		return
	
	var player_z = player.global_position.z
	
	# Spawn new tiles if needed
	while player_z + (tiles_ahead * tile_length) > last_tile_z:
		spawn_tile(last_tile_z + tile_length)

	# Clean up old tiles
	while spawned_tiles.size() > max_tiles:
		var old_tile = spawned_tiles.pop_front()
		if is_instance_valid(old_tile):
			old_tile.queue_free()

func spawn_tile(z_position: float):
	var tile = road_tile_scene.instantiate()

	# Set tile's position in front of the last one
	tile.position = Vector3(0, 0, z_position)
	add_child(tile)
	
	spawned_tiles.append(tile)
	last_tile_z = z_position
	
	if tile.has_method("set_player"):
		tile.set_player(player)
	
	# If the tile has an obstacle script, spawn it
	if tile.has_method("spawn_obstacle"):
		tile.spawn_obstacle(player)
