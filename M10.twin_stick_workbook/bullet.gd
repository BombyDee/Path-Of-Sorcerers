class_name Bullet extends Area2D

@export var speed = 800

var max_range = 1000.0

var _distance_traveled = 0.0

func _physics_process(delta):
	var distance = Vector2.RIGHT.rotated(rotation)
	position += distance * speed * delta

	_distance_traveled += speed * delta
	if _distance_traveled > max_range:
		_destroy()

func _destroy():
	queue_free()
