extends AnimationPlayer

var hits = 0
var played = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# func _on_area_2d_body_entered(body):
# 	print(body)
# 	if body is Bullet:
# 		hits += 1
	
# 	if hits >= 5 and not played:
# 		play("turn")
# 		played = true

func end_animation():
	play("turn")
