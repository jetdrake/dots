extends Control

signal selected(dot)
export var dot : Dictionary
onready var sprite = $CenterContainer/Sprite
# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.texture_normal = load(dot.texture_path)

func set_disabled():
	sprite.modulate = Color(0,0,1)

func _on_Sprite_pressed():
	emit_signal("selected", dot)
