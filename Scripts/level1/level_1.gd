extends Node2D
class_name Level1

@onready var tile_map = $TileMap
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_bullet_body_entered(body):
	if body is Level1:
		print("Level")
	if body is Bullet:
		print("Bullet")
	if body is TileMap:
		print("TileMap")
	var position = body.position
	var surr_cells = tile_map.get_surrounding_cells(position)
	for cell in surr_cells:
		#erase_cell(0, cell)
		print("Global:" + str(global_position))
		print("Position:" + str(position))
		#print("Texture is " + str(texture))
		
		print(cell)
		tile_map.set_cell(0, cell, 0, Vector2i(3, 3))
	#clear()
