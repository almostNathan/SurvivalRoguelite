extends Node2D

# Constants
const TILE_SIZE = 16  # Base tile size in pixels
const CHUNK_SIZE = 8  # Chunk size in tiles
const SCREEN_TILES_X = 1080/TILE_SIZE  # 1080/32 rounded up
const SCREEN_TILES_Y = 720/TILE_SIZE  # 720/32 rounded up
const VISIBLE_CHUNK_RADIUS = 6

# Nodes
@onready var base_tilemap: TileMap = get_node("../BaseTileMap")
@onready var detail_tilemap: TileMap = get_node("../DetailTileMap")
#@onready var detail_tilemap: TileMap = $DetailTileMap

# Storage
var active_chunks = {}  # Format: "x,y": ChunkData
var detail_positions = {}  # Format: "x,y": DetailData
var rng = RandomNumberGenerator.new()
var current_level = 0



class ChunkDetails:
	var positions: Array[Vector2i] = []
	var tile_indices: Array[int] = []


class ChunkData:
	var position: Vector2i
	var start_position: Vector2i
	var details: ChunkDetails
	
	func _init(coords: Vector2i):
		self.position = coords
		self.details = ChunkDetails.new()
		self.start_position = coords * CHUNK_SIZE




func _ready():
	rng.randomize()
	initialize_visible_chunks(Vector2i.ZERO)

func _on_main_changing_level(new_level_number):
	current_level = new_level_number
	for chunk_key in active_chunks.keys():
		remove_chunk(chunk_key)


#Set up tiles at start of game
func initialize_visible_chunks(center_pos: Vector2i):
	var chunk_coords = world_to_chunk(center_pos)
	for x in range(-VISIBLE_CHUNK_RADIUS, VISIBLE_CHUNK_RADIUS+1):
		for y in range(-VISIBLE_CHUNK_RADIUS, VISIBLE_CHUNK_RADIUS+1):
			var chunk_pos = Vector2i(chunk_coords.x + x, chunk_coords.y + y)
			generate_chunk(chunk_pos)

func generate_chunk(chunk_coords: Vector2i):
	if active_chunks.has(chunk_key(chunk_coords)):
		return
		
	var chunk = ChunkData.new(chunk_coords)
	# Generate base grass with variations
	generate_base_tiles(chunk)
	
	# Store details in chunk object
	generate_and_store_details(chunk)
	active_chunks[chunk_key(chunk_coords)] = chunk
	#apply_chunk_details(chunk)


func generate_base_tiles(chunk: ChunkData):
	var chunk_start = chunk.position * CHUNK_SIZE
	for x in range(CHUNK_SIZE):
		for y in range(CHUNK_SIZE):
			var x_coord
			var y_coord
			if current_level == 0:
				x_coord = 2
				y_coord = 1
			else:
				x_coord = (x%2)+4
				y_coord = y%2
			var pos = chunk_start + Vector2i(x, y)
				
			base_tilemap.set_cell(0, pos, current_level, Vector2i(x_coord, y_coord))

func erase_base_tiles(chunk: ChunkData):
	var chunk_start = chunk.position * CHUNK_SIZE
	for x in range(CHUNK_SIZE):
		for y in range(CHUNK_SIZE):
			var pos = chunk_start + Vector2i(x, y)
			base_tilemap.erase_cell(0, pos)



func world_to_chunk(world_pos: Vector2i) -> Vector2i:
	return Vector2i(
		floor(float(world_pos.x) / (CHUNK_SIZE * TILE_SIZE)),
		floor(float(world_pos.y) / (CHUNK_SIZE * TILE_SIZE))
	)

func chunk_key(chunk_coords: Vector2i) -> String:
	return "%d,%d" % [chunk_coords.x, chunk_coords.y]

##
##Function Called from Main Scene
##
func update_chunks(center_pos: Vector2i):
	var current_chunk = world_to_chunk(center_pos)
	var chunks_to_remove = []

	# Check for chunks to remove
	for chunk_key in active_chunks:
		var chunk_coords = active_chunks[chunk_key].position
		if abs(chunk_coords.x - current_chunk.x) > VISIBLE_CHUNK_RADIUS or \
			abs(chunk_coords.y - current_chunk.y) > VISIBLE_CHUNK_RADIUS:
				chunks_to_remove.append(chunk_key)

	# Remove distant chunks
	#for chunk_key in chunks_to_remove:
		#remove_chunk(chunk_key)
	
	# Generate new chunks
	initialize_visible_chunks(center_pos)

func apply_chunk_details(chunk: ChunkData):
	# Apply the stored details to the tilemap
	for i in range(chunk.details.positions.size()):
		var pos = chunk.details.positions[i] + chunk.start_position
		var tile_index = chunk.details.tile_indices[i]
		pos += Vector2i(4,4) - detail_tilemap.tile_set.get_pattern(tile_index).get_size()
		detail_tilemap.set_pattern(0, pos, detail_tilemap.tile_set.get_pattern(tile_index))
	



# Add this function to clear details when removing chunks
func remove_chunk(chunk_coords):
	if active_chunks.has(chunk_coords):
		var chunk = active_chunks[chunk_coords]
		if chunk:
			# Clear the details for this chunk
			for pos in chunk.details.positions:
				detail_tilemap.erase_cell(0, pos)
			erase_base_tiles(chunk)
			active_chunks.erase(chunk_coords)


#Generates and stores details for each chunk.
func generate_and_store_details(chunk: ChunkData):
	var chunk_start = chunk.position * CHUNK_SIZE	
	var tileset_id = 1
	#put an obstacle on every other chunk
	#if chunk.position % 2 == Vector2i(0, 0):
	if (randf() * 10) < 1:
		var pattern_num = detail_tilemap.tile_set.get_patterns_count()
		var pattern_selection_index = randi_range(0,pattern_num-1)
		chunk.details.tile_indices.append(pattern_selection_index)
		chunk.details.positions.append(Vector2i(0,0))

		
	#if chunk.position % 4 == Vector2i(0,0):
		#for x in range(CHUNK_SIZE):
			#for y in range(CHUNK_SIZE):
				#var pos = chunk_start + Vector2i(x,y)
				##Left Wall
				#if x==1 and y<7 and y>0:
					#var y_coord = y%2
					#detail_tilemap.set_cell(0, pos, tileset_id, Vector2i(5, y_coord))
				##Right Wall
				#if x==6 and y<7 and y>0:
					#var y_coord = y%2
					#detail_tilemap.set_cell(0, pos, tileset_id, Vector2i(0, y_coord))
				##Top Wall
				#if y==1 and x<7 and x>0:
					#var x_coord = (x%2)+1
					#detail_tilemap.set_cell(0, pos, tileset_id, Vector2i(x_coord, 4))
				##Bottom Wall
				#if y==6 and x<7 and x>0:
					#var x_coord = (x%2)+1
					#detail_tilemap.set_cell(0, pos, tileset_id, Vector2i(x_coord, 0))
				#if x==1 and y==1:
					#detail_tilemap.set_cell(0, pos, tileset_id, Vector2i(0, 5))
				#if x==6 and y==1:
					#detail_tilemap.set_cell(0, pos, tileset_id, Vector2i(3, 5))
				#if x>1 and x<6 and y>1 and y<6:
					#detail_tilemap.set_cell(0, pos, tileset_id, Vector2i(8, 7))


	
	
	
	## Adds pattern details
	#var keep_going = true
	#for x in range(CHUNK_SIZE):
		#for y in range(CHUNK_SIZE):
			#if keep_going:
				#if rng.randf() < 0.01:  # 1% chance for a detail
					#keep_going = false
					#var position = Vector2i(x, y)
					## Store the tile index for this detail
					#var selected_pattern_index = rng.randi_range(0, 3)
					#var pattern_size = detail_tilemap.tile_set.get_pattern(selected_pattern_index).get_size()
					#if (position + pattern_size) >= Vector2i(CHUNK_SIZE, CHUNK_SIZE): 
						#position -= pattern_size
					#chunk.details.tile_indices.append(selected_pattern_index)  # Adjust range based on your tileset
					#chunk.details.positions.append(position)



