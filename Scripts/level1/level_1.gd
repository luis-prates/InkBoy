extends Node2D
class_name Level1

@onready var tile_map = $TileMap

enum Side { Up, Down, Left, Right }

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
		var side
		var position = body.position.round()
		var all_tiles = tile_map.get_used_cells(2)
		var collision_cell = tile_map.local_to_map(tile_map.to_local(position))
		var atlas_center_x = 0
		var atlas_center_y = 0
		var first_x = 0
		var first_y = 0
		if Vector2i(collision_cell.x, collision_cell.y - 1) not in all_tiles:
			side = Side.Up
			atlas_center_x = 7
			atlas_center_y = 1
			first_x = -2
			first_y = 0
		elif Vector2i(collision_cell.x, collision_cell.y + 1) not in all_tiles:
			side = Side.Down
			atlas_center_x = 2
			atlas_center_y = 1
			first_x = -2
			first_y = 0
		elif Vector2i(collision_cell.x - 1, collision_cell.y) not in all_tiles:
			side = Side.Left
			atlas_center_x = 10
			atlas_center_y = 2
			first_x = 0
			first_y = -2
		elif Vector2i(collision_cell.x + 1, collision_cell.y) not in all_tiles:
			side = Side.Right
			atlas_center_x = 16
			atlas_center_y = 2
			first_x = 0
			first_y = -2
		
		print("Side is: " + str(side));
		
		if collision_cell not in all_tiles:
			match side:
				Side.Up:
					collision_cell.y += 1
				Side.Down:
					collision_cell.y -= 1
				Side.Left:
					collision_cell.x += 1
				Side.Right:
					collision_cell.x -= 1
		
		var collision_cell_x = collision_cell.x
		var collision_cell_y = collision_cell.y
		
		
		if side == Side.Up:
			for y in range(collision_cell_y, collision_cell_y + 2):
				first_x = -2
				for x in range(collision_cell_x - 2, collision_cell_x + 3):
					if (Vector2i(x, y) in all_tiles):
						tile_map.set_cell(2, Vector2i(x, y), 3, Vector2i(atlas_center_x + first_x, atlas_center_y + first_y))
						first_x += 1
				first_y += 1
		elif side == Side.Down:
			for y in range(collision_cell_y - 1, collision_cell_y + 1):
				first_x = -2
				for x in range(collision_cell_x - 2, collision_cell_x + 3):
					if (Vector2i(x, y) in all_tiles):
						tile_map.set_cell(2, Vector2i(x, y), 3, Vector2i(atlas_center_x + first_x, atlas_center_y + first_y))
						first_x += 1
				first_y += 1
		elif side == Side.Left:
			for x in range(collision_cell_x, collision_cell_x + 2):
				first_y = -2
				for y in range(collision_cell_y - 2, collision_cell_y + 3):
					if (Vector2i(x, y) in all_tiles):
						tile_map.set_cell(2, Vector2i(x, y), 3, Vector2i(atlas_center_x + first_x, atlas_center_y + first_y))
						first_y += 1
				first_x += 1
		elif side == Side.Right:
			for x in range(collision_cell_x - 1, collision_cell_x + 1):
				first_y = -2
				for y in range(collision_cell_y - 2, collision_cell_y + 3):
					if (Vector2i(x, y) in all_tiles):
						tile_map.set_cell(2, Vector2i(x, y), 3, Vector2i(atlas_center_x + first_x, atlas_center_y + first_y))
						first_y += 1
				first_x += 1
		body.queue_free()
	if body is TileMap:
		print("TileMap")
