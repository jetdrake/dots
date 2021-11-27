extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()
var last_velocity = Vector2()
var vertical = false
var rng = RandomNumberGenerator.new()

func _init():
	rng.randomize()
	var spawner = rng.randi_range(1,50)
	print(spawner)
	if (spawner %2 == 0):
		velocity.x = 1 * speed
	else:
		velocity.y = 1 * speed
		vertical = true

func _physics_process(_delta):
	velocity = move_and_slide(velocity)
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider is TileMap:
			if vertical:
				velocity.y = collision.normal.y * speed
			else:
				velocity.x = collision.normal.x * speed
