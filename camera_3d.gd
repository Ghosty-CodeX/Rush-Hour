extends Camera3D

@export var target_path: NodePath
@export var follow_distance: Vector3 = Vector3(0, 5, 10)
@export var follow_speed: float = 5.0

var target: Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	target = get_node(target_path)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target:
		var target_position = target.global_transform.origin - target.global_transform.basis.z  * follow_distance.z
		target_position.y += follow_distance.y
		target_position.x = target.global_transform.origin.x
		
		
		global_transform.origin = global_transform.origin.lerp(target_position, follow_speed * delta)
		
		look_at(target.global_transform.origin, Vector3.UP)
