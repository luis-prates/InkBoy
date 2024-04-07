extends TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_bullet_body_entered(body):
	var position = body.position
	body.clear()
	var surr_cells = get_surrounding_cells(position)
	for cell in surr_cells:
		#erase_cell(0, cell)
		print("Global:" + str(global_position))
		print("Position:" + str(position))
		#print("Texture is " + str(texture))
		var tile : Vector2 = map_to_local(cell)
		print(tile)
		set_cell(0, tile, 0, Vector2i(3, 3))
		print("Erasing cell at: " + str(cell))
	#clear()
