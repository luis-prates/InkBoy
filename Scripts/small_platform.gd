extends Node2D
class_name SmallPlatform

@onready var tile_map = $TileMap2

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
		var position = body.position
		var surr_cells = tile_map.get_surrounding_cells(position)
		print(surr_cells)
		for cell in surr_cells:
			var collision_cell = tile_map.local_to_map(tile_map.to_local(cell))
			var collision_cell_x = collision_cell.x
			var collision_cell_y = collision_cell.y
			for x in range(collision_cell_x - 2, collision_cell_x + 2):
				for y in range(collision_cell_y, collision_cell_y + 2):
					tile_map.set_cell(0, Vector2i(x, y), 0, Vector2i(3, 3))
				
			
			body.queue_free()
			#tile_map.set_cell(0, Vector2i(4, 27), 0, Vector2i(3, 3))
	if body is TileMap:
		print("TileMap")
