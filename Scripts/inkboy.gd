extends Node2D

@onready var deathzone1 = $Deathzone1
@onready var deathzone2 = $Deathzone2

var boy = null 

# Called when the node enters the scene tree for the first time.
func _ready():
	boy = get_tree().get_first_node_in_group("boy")
	if boy:
		boy.global_position = Vector2i(200, 934)
	deathzone1.body_entered.connect(_on_deathzone1_body_entered)
	deathzone2.body_entered.connect(_on_deathzone2_body_entered)
	
func _on_deathzone1_body_entered(body):
	AudioPlayer.play_sfx("hurt")
	reset_player_checkpoint1()
	
func _on_deathzone2_body_entered(body):
	AudioPlayer.play_sfx("hurt")
	reset_player_checkpoint2()

func reset_player_checkpoint1():
	boy.velocity = Vector2.ZERO
	boy.global_position = Vector2i(1200, 1000)
	
func reset_player_checkpoint2():
	boy.velocity = Vector2.ZERO
	boy.global_position = Vector2i(2800, 550)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
