extends Control

var dots_path = "res://dots/dots.json"
var save_path = "res://save.json"
onready var stats = $"/root/Stats"
onready var save_file = $"/root/SaveFile"
onready var grid = $VBoxContainer/GridContainer
var dot_container = preload("res://DotContainer.tscn")
var dots = []
# Called when the node enters the scene tree for the first time.
func _ready():
	# get save data
	var save = save_file.load_data()
	stats.save_data = save
	
	# open dots data
	var file = File.new()
	if not file.file_exists(dots_path):
		print("no dots data")
		return
	
	file.open(dots_path, file.READ)
	var text = file.get_as_text()
	dots = parse_json(text)
	for i in dots.size():
		print(i)
		var dc = dot_container.instance()
		dc.dot = dots[i]
		grid.add_child(dc)
		if save.high_score >= 5*i:
			dc.connect("selected", self, "_on_selected")
		else:
			dc.set_disabled()
			print(dc.dot.name, ' is unavailable')
	file.close()

func _on_selected(dot):
	print("on selected ", dot)
	stats.dot = dot
	var _scene = get_tree().change_scene("res://World.tscn")
