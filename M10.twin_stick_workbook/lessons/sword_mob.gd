class_name Mob extends CharacterBody2D

@export var speed := 500.0
@export var acceleration := 850.0
@export var health := 500: set = set_health

var damage := 10.0

var _player: Player = null

@onready var detection_area: Area2D = %"Detection Area"
@onready var hitbox: Area2D = $Hitbox

func set_health(new_health: int) -> void:
	health = new_health
	if health <= 0:
		die()
		
func die() -> void:
	queue_free()

func _ready() -> void:
	detection_area.body_entered.connect(func (body: Node) -> void:
		if body is Player:
			_player = body
	)
	
	detection_area.body_exited.connect(func (body: Node) -> void:
		if body is Player:
			_player == null
	)
	
	hitbox.body_entered.connect(func (body: Node) -> void:
		if body is Player:
			body.health -= damage
	)
	
func _physics_process(delta: float) -> void:
	if _player == null:
		velocity = velocity.move_toward(Vector2.ZERO, acceleration * delta)
	else:
		var direction := global_position.direction_to(_player.global_position)
		var distance := global_position.distance_to(_player.global_position)
		var speed := speed if distance > 120.0 else speed * distance / 120.0
		var desired_velocity := direction * speed
		velocity = velocity.move_toward(desired_velocity, acceleration * delta)
		
	move_and_slide()
