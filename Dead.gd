extends Control

var respawn = false
onready var stats = $"/root/Stats"
onready var save_file = $"/root/SaveFile"

func _ready():
	stats.save_data.high_score = max(stats.save_data.high_score, stats.score)
	save_file.save_data(stats.save_data)
	$score.text = String(stats.score)
	$high_score.text = String(stats.save_data.high_score)

func _input(event):
	if event is InputEventKey:
		if event.pressed and respawn:
			get_tree().change_scene("res://PlayerSelect.tscn")

func _on_Timer_timeout():
	respawn = true
