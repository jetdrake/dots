extends Node

var save_path = "res://save.json"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass 
	
func load_data():
	var file = File.new()
	
	# open save data
	if not file.file_exists(save_path):
		print("no save data")
		return
	
	file.open(save_path, file.READ)
	var save_text = file.get_as_text()
	var save = parse_json(save_text)
	file.close()
	return save

func save_data(data):
	var file = File.new()
	
	# open save data
	if not file.file_exists(save_path):
		print("no save data")
		return
	
	file.open(save_path, file.WRITE)
	file.store_line(to_json(data))
	file.close()
