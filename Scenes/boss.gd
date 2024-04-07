extends AnimationPlayer

var hits = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	print("Entered")
	print(body)
	if body is Bullet:
		hits += 1
		print("Hit: " + str(hits))
	
	if hits >= 5:
		play("turn")
		print("Play")
