extends Node2D

var ham = preload("res://Ham.tscn")
var mimi = preload("res://Mimi.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var top = $Top
onready var bottom = $Bottom
onready var player = $Player
onready var ui_score = $HUD/Score
onready var stats = $"/root/Stats"

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	stats.score = 0
	player.create_dot(stats.dot)

func spawn_random_ham():
	var h = ham.instance()
	h.position = randPosition()
	call_deferred("add_child", h)

func spawn_random_mimi():
	var m = mimi.instance()
	m.position = randPosition()
	call_deferred("add_child", m)

func randPosition():
	var h_position = Vector2()
	while true:
		rng.randomize()
		h_position.x = rng.randi_range(top.position.x, bottom.position.x)
		h_position.y = rng.randi_range(bottom.position.y, top.position.y)
		
		if h_position.distance_to(player.position) > 150:
			break
	
	return h_position

func increment_mimis():
	stats.score += 1
	ui_score.text = String(stats.score)
	check_invincibility()

func check_invincibility():
	if stats.score % 5 == 0:
		player.set_invincible()

func _on_Player_monch():
	spawn_random_ham()
	spawn_random_mimi()
	increment_mimis()

func _on_Player_dead():
	var _scene = get_tree().change_scene("res://Dead.tscn")
