extends CharacterBody2D
class_name Player

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var speed = 350
var jump_force = -500
const bullet = preload("res://Scenes/Bullet.tscn")
var active = true
var Jump_Buffer_Timeout = true
var jump_available = true

@onready var Jump_Buffer = $Jump_Buffer
@onready var Coyote_timer = $Coyote_timer
@onready var hand_sprite = $Hand/hand_sprite
@onready var hand = $Hand
@onready var animation = $AnimationPlayer

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
		jump_available = true
		
	if direction:
		animation.play("move")
	else:
		animation.play("idle")
	
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("move_up") and (is_on_floor() or !Coyote_timer.is_stopped()):
		#AudioPlayer.play_sfx("jump")
		if jump_available:
			jump()
	
	if Input.is_action_just_pressed("move_up") and not is_on_floor():
		Jump_Buffer_Timeout = false
		Jump_Buffer.start()
	
	if is_on_floor() and not Jump_Buffer_Timeout and jump_available:
		jump()
	
	var was_on_floor = is_on_floor()
	move_and_slide()
	
	if was_on_floor and not is_on_floor():
		Coyote_timer.start()
	
	
	
func point():
	var mouse_pos = get_global_mouse_position()
	
	
	hand.look_at(mouse_pos)
	if hand.rotation_degrees > 360:
		hand.rotation_degrees = 0
	elif hand.rotation_degrees < 0:
		hand.rotation_degrees = 360

	if hand.rotation > TAU / 4 and hand.rotation < 3 * TAU / 4:
		hand_sprite.flip_h = false
		hand_sprite.flip_v = true
	else:
		hand_sprite.flip_h = false
		hand_sprite.flip_v = false

func _ready():
	pass

func _process(delta):
	point()
	
func _physics_process(delta):
	if not active:
		return

	move(delta)
	
	if not $Hand/RayCast.is_colliding():
		shoot()

func jump():
	velocity.y = jump_force
	jump_available = false
	
func _on_jump_buffer_timeout():
	Jump_Buffer_Timeout = true
