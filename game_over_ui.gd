extends CanvasLayer

@onready var restart_button = $ColorRect/VBoxContainer/Restart


func _ready():
	restart_button.pressed.connect(_on_restart_pressed)
	visible = false
	

func show_game_over():
	visible = true

func _on_restart_pressed():
	print("🔁 Restart pressed")
	get_tree().paused = false
	get_tree().reload_current_scene()
