extends CharacterBody2D
class_name Player

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var speed = 350
var jump_force = -500
const bullet = preload("res://Scenes/Bullet.tscn")
var active = true

var coyote_frames = 6
var coyote = false
var last_floor = false
var jumping = false 

@onready var Coyote_timer = $Coyote
@onready var hand = $Hand/hand_sprite

func _on_coyote_timeout():
	coyote = false

func set_active(state):
	active = state

func shoot():
	if Input.is_action_just_pressed("shoot"):
		var new_bullet = bullet.instantiate()
		new_bullet.global_position = %Marker.global_position
		new_bullet.global_rotation = %Marker.global_rotation
		owner.add_child(new_bullet)

func move(delta):
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = speed * direction
	
	if is_on_floor():
		jumping = false
		last_floor = true

	if not is_on_floor():
		velocity.y += gravity * delta

	if not is_on_floor() and last_floor and not jumping:
		coyote = true
		Coyote_timer.start()

	if Input.is_action_just_pressed("move_up") and (is_on_floor() or coyote):
		#AudioPlayer.play_sfx("jump")
		velocity.y = jump_force
		jumping = true
	
	print("Timer" + str(Coyote_timer.wait_time) + "| jumping: " + str(jumping) + "| coyote: " + str(coyote) + "| is on floor: " + str(is_on_floor()) + "| last floor:" + str(last_floor))


	
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


func _ready():
	Coyote_timer.wait_time = coyote_frames / 60.0

func _process(delta):
	point()
	
func _physics_process(delta):
	if not active:
		return
	
	move(delta)
	move_and_slide()

	
	if not $Hand/RayCast.is_colliding():
		shoot()

