extends Node2D
class_name Level1

@onready var tile_map = $TileMap
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	var object_id = body.get_instance_id()
	if body is Level1:
		print("Level")
	if body is Bullet:
		print("Bullet")
		var position = body.position.round()
		var all_tiles = tile_map.get_used_cells(2)
		var collision_cell = tile_map.local_to_map(tile_map.to_local(position))
		var collision_cell_x = collision_cell.x
		var collision_cell_y = collision_cell.y
		var first_x = -2
		var first_y = 1
		
		for y in range(collision_cell_y, collision_cell_y + 2):
			first_x = -2
			for x in range(collision_cell_x - 2, collision_cell_x + 3):
				if (Vector2i(x, y) in all_tiles):
					print("X atlas: " + str(2 + first_x) + " Y atlas: " + str(0 + first_y))
					tile_map.set_cell(2, Vector2i(x, y), 3, Vector2i(2 + first_x, 0 + first_y))
					first_x += 1
			first_y += 1
		body.queue_free()
	if body is TileMap:
		print("TileMap")
