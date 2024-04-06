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
		var cell = tile_map.local_to_map(tile_map.to_local(position))
		
		var all_tiles = tile_map.get_used_cells(0)
		var collision_cell = cell
		var collision_cell_x = collision_cell.x
		var collision_cell_y = collision_cell.y
		for y in range(collision_cell_y, collision_cell_y + 2):
			for x in range(collision_cell_x - 2 + y, collision_cell_x + 2 - y):
				if (Vector2i(x, y) in all_tiles):
					tile_map.set_cell(0, Vector2i(x, y), 0, Vector2i(3, 3))
		body.queue_free()
		#for cell in surr_cells:
			#print("Surr cell: " + str(tile_map.local_to_map(tile_map.to_local(cell))))
			#var collision_cell = tile_map.local_to_map(tile_map.to_local(cell))
			#var collision_cell_x = collision_cell.x
			#var collision_cell_y = collision_cell.y
			##for y in range(collision_cell_y, collision_cell_y + 2):
				##for x in range(collision_cell_x - 2 + y, collision_cell_x + 2 - y):
					##tile_map.set_cell(0, Vector2i(x, y), 0, Vector2i(3, 3))
			#
			#body.queue_free()
			#tile_map.set_cell(0, collision_cell, 0, Vector2i(3, 3))
	if body is TileMap:
		print("TileMap")

