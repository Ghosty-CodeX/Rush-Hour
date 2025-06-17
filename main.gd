extends Node3D

@onready var player = $player
@onready var game_over_ui = $GameOverUI
@onready var score_label = $ScoreLabel

var start_z := 0.0
var current_Score := 0.0
var game_active := true


func _ready():
	start_z = player.global_position.z
	current_Score = 0

func _process(_delta):
	if game_active:
		var distance = player.global_position.z - start_z
		current_Score = max(distance, 0)
		score_label.text = "Score: %d" % current_Score
