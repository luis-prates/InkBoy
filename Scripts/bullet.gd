extends RigidBody2D
class_name Bullet

signal collided
var speed = 750
var range = 1500
var deceleration = 500
var travel_distance = 0
var CycleCount = 0
var SecondCount = 0

func _ready():
	var final_impulse = global_transform.basis_xform(Vector2(speed, 0))
	apply_impulse(final_impulse, Vector2(0, 0))

func _physics_process(delta):
	travel_distance += speed * delta
	if travel_distance > range:
		queue_free()
	#var direction = Vector2.RIGHT.rotated(rotation)
	##position += ((direction * speed) - Vector2(deceleration, gravity)) * delta
	#var final_impulse = global_transform.basis_xform(Vector2(speed, 100))
	#apply_impulse(final_impulse, Vector2(0, 0))
	#CycleCount += 1
	#if CycleCount >= 60:
		#CycleCount = 0
		#
	#SecondCount += 5
	#speed = clamp(speed - SecondCount, 0, speed)
	#
	#if speed <= 0:
		#pass
	#else:
		#position += direction * speed * delta
		#CycleCount = 0
		#SecondCount = 0
	
	
	

func _on_body_entered(body):
	queue_free()
	#if body.has_method("take_damage"):
		#body.take_damage()
