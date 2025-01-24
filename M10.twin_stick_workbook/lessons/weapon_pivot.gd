extends Node2D

var gamepad = false

@onready var weapon_anchor: Marker2D = %WeaponAnchor

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion or event is InputEventKey:
		gamepad = false
	elif event is InputEventJoypadButton or event is InputEventKey:
		gamepad = true



func _process(delta: float) -> void:
	var hand_direction := Vector2.ZERO
	if gamepad:
		hand_direction = Input.get_vector("hand_right","hand_left","hand_up","hand_down")
	else:
		hand_direction = global_position.direction_to(get_global_mouse_position())
	if hand_direction.length() > 0.1:
		rotation = hand_direction.angle()
