extends CharacterBody2D
class_name Player

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var speed = 350
@export var jump_force = -500
const bullet = preload("res://Scenes/Bullet.tscn")

@onready var hand = $Hand/hand_sprite

func shoot():
	if Input.is_action_just_pressed("shoot"):
		var new_bullet = bullet.instantiate()
		new_bullet.global_position = %Marker.global_position
		new_bullet.global_rotation = %Marker.global_rotation
		owner.add_child(new_bullet)

func move(delta):
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = speed * direction
	if not is_on_floor():
		velocity.y += gravity * delta
	if Input.is_action_just_pressed("move_up") && is_on_floor():
		velocity.y = jump_force
	move_and_slide()
	
func point():
	var mouse_pos = get_global_mouse_position()
	
	#if abs(fmod($Hand.rotation, TAU)) > deg_to_rad(90) and abs(fmod($Hand.rotation, TAU)) < deg_to_rad(270):
		#hand.flip_h = true
		#hand.flip_v = true
		#mouse_pos = Vector2(global_position + (global_position - mouse_pos))
	#else:
		#hand.flip_h = false
		#hand.flip_v = false
	
	$Hand.look_at(mouse_pos)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	point()
	
func _physics_process(delta):
	move(delta)
	if not $Hand/RayCast.is_colliding():
		shoot()
