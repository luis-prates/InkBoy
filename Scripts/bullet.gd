extends RigidBody2D
class_name Bullet

signal collideda
var speed = 750
var range = 1500
var deceleration = 500
var travel_distance = 0
var CycleCount = 0
var SecondCount = 0

@onready var ball = $ball

func _ready():
	var final_impulse = global_transform.basis_xform(Vector2(speed, 0))
	apply_impulse(final_impulse, Vector2(0, 0))

func _physics_process(delta):
	travel_distance += speed * delta
	if travel_distance > range:
		queue_free()
