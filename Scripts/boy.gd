extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var speed = 600
@export var jump_force = -400

func move(delta):
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = speed * direction
	if not is_on_floor():
		velocity.y += gravity * delta
	if Input.is_action_just_pressed("move_up") && is_on_floor():
		velocity.y = jump_force
	move_and_slide()
	
func point(delta):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	point(delta)
	
func _physics_process(delta):
	move(delta)
