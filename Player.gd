extends KinematicBody2D

export (int) var speed = 200
export (float) var size = 1
export (float) var i_time = 3.0
onready var Ham = preload("res://Ham.tscn")
onready var Mimi = preload("res://Mimi.tscn")
onready var invincibility = $Invincibility
onready var animation = $AnimationPlayer
onready var sprite = $Sprite
signal monch
signal dead

var self_dot = {
	"name": "default",
	"texture_path": "res://icon.png"
}

var velocity = Vector2()
var invincible = false

func create_dot(dot):
	self_dot = dot
	sprite.texture = load(dot.texture_path)
	speed = dot.stats.speed
	size = dot.stats.size
	i_time = dot.stats.invincibility
	set_size()

func set_size():
	scale.x *= size
	scale.y *= size

func _ready():
	sprite.texture = load(self_dot.texture_path)
	animation.playback_active = false

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)

func _on_HitBox_area_entered(area):
	print('monch')
	area.get_parent().queue_free()
	emit_signal("monch")

func _on_HurtBox_area_entered(area):
	if invincible:
		print('invincible')
		area.get_parent().queue_free()
	else:
		queue_free()
		emit_signal("dead")

func set_invincible():
	invincible = true
	animation.playback_active = true
	animation.play("Invincible")
	invincibility.start(i_time)


func _on_Invincibility_timeout():
	invincible = false
	animation.stop(true)
	sprite.use_parent_material = true
