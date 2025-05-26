extends CanvasLayer

@onready var play_button := $PlayButton

# Called when the node enters the scene tree for the first time.
func _ready():
	play_button.pressed.connect(_on_play_pressed)

func _on_play_pressed():
	visible = false
	get_tree().paused = false
