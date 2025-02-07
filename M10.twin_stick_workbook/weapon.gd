extends Node2D

@export var bullet_scene: PackedScene = preload("res://lessons/bullet.tscn")


@export var speed = 800

@export_range(0.0, 360.0, 1.0, "randians_as_degrees") var random_angle := PI / 12.0

@export_range(100.0, 2000.0, 1.0) var max_range := 1000.0

@export_range(100.0, 3000.0, 1.0) var max_speed := 1500.0

func _shoot():
	var bullet : Node = bullet_scene.instantiate()
	get_tree().current_scene.add_child(bullet)

	bullet.global_position = global_position
	bullet.global_rotation = global_rotation
	bullet.max_range = max_range
	bullet.speed = max_speed 
	bullet.rotation += randf_range(-random_angle / 3.0, random_angle / 3.0)

func _physics_process(_delta):
	if Input.is_action_pressed("_shoot"):
		_shoot()
