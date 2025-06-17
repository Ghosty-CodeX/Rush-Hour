extends CanvasLayer

var originalScale := {}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	originalScale[$VBoxContainer/StartButton] = $VBoxContainer/StartButton.scale
	originalScale[$VBoxContainer/QuitButton] = $VBoxContainer/QuitButton.scale

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_mouse_entered() -> void:
	brighter_button($VBoxContainer/StartButton, true)

func _on_start_button_mouse_exited() -> void:
	brighter_button($VBoxContainer/StartButton, false)

func _on_quit_button_mouse_entered() -> void:
	brighter_button($VBoxContainer/QuitButton, true)

func _on_quit_button_mouse_exited() -> void:
	brighter_button($VBoxContainer/QuitButton, false)

func _on_start_button_pressed() -> void:
	button_scale($VBoxContainer/StartButton)
	get_tree().change_scene_to_file("res://main.tscn")

func _on_quit_button_pressed() -> void:
	button_scale($VBoxContainer/QuitButton)
	get_tree().quit()



func button_scale(button: TextureButton):
	button.scale = originalScale[button] * 0.9

func reset_button(button: TextureButton):
	button.scale = originalScale[button]
	
func brighter_button(button: TextureButton, brighten: bool) -> void:
	if brighten:
		button.modulate = Color(1.1, 1.1, 1.1) #Brightens
	else:
		button.modulate = Color(1.0, 1.0, 1.0) #Resets
