extends Node2D

# Constants
const TILE_SIZE = 16  # Base tile size in pixels
const CHUNK_SIZE = TILE_SIZE  # Chunk size in tiles
const SCREEN_TILES_X = 1080/TILE_SIZE  # 1080/32 rounded up
const SCREEN_TILES_Y = 720/TILE_SIZE  # 720/32 rounded up
const VISIBLE_CHUNK_RADIUS = 3

# Nodes
@onready var base_tilemap: TileMap = get_node("../BaseTileMap")
@onready var detail_tilemap: TileMap = get_node("../DetailTileMap")
#@onready var detail_tilemap: TileMap = $DetailTileMap

# Pattern definitions
class PatternDetail:
	var pattern_id: int      # Pattern ID from TileSet
	var size: Vector2i       # Size in tiles
	var weight: float        # Spawn weight
	var can_flip: bool
	var can_rotate: bool
	
	func _init(id: int, s: Vector2i, w: float, flip: bool = true, rot: bool = true):
		pattern_id = id
		size = s
		weight = w
		can_flip = flip
		can_rotate = rot

# Storage
var active_chunks = {}  # Format: "x,y": ChunkData
var detail_positions = {}  # Format: "x,y": DetailData
var rng = RandomNumberGenerator.new()

# Configure your patterns here
var pattern_details: Array[PatternDetail] = [
	# Example patterns - update these with your actual pattern IDs and sizes
	PatternDetail.new(0, Vector2i(1, 3), 1.0),
	PatternDetail.new(1, Vector2i(3, 3), 1.0),
	PatternDetail.new(2, Vector2i(1, 3), 1.0),
	PatternDetail.new(2, Vector2i(3, 3), 1.0),
	PatternDetail.new(2, Vector2i(3, 1), 1.0)
]

class ChunkDetails:
	var positions: Array[Vector2i] = []
	var tile_indices: Array[int] = []

class ChunkData:
	var position: Vector2i
	var details: ChunkDetails
	
	func _init(coords: Vector2i):
		self.position = coords
		self.details = ChunkDetails.new()




func _ready():
	rng.randomize()
	initialize_visible_chunks(Vector2i.ZERO)

#Set up tiles at start of game
func initialize_visible_chunks(center_pos: Vector2i):
	#print(center_pos)
	var chunk_coords = world_to_chunk(center_pos)
	#print("chunk coords",chunk_coords)
	for x in range(-VISIBLE_CHUNK_RADIUS, VISIBLE_CHUNK_RADIUS):
		for y in range(-VISIBLE_CHUNK_RADIUS, VISIBLE_CHUNK_RADIUS):
			var chunk_pos = Vector2i(chunk_coords.x + x, chunk_coords.y + y)
			generate_chunk(chunk_pos)

func generate_chunk(chunk_coords: Vector2i):

	if active_chunks.has(chunk_key(chunk_coords)):
		return


	var chunk = ChunkData.new(chunk_coords)
	# Generate base grass with variations
	generate_base_tiles(chunk)
	
	# Generate details
	generate_and_store_details(chunk)
	
	active_chunks[chunk_key(chunk_coords)] = chunk
	
	apply_chunk_details(chunk)


func generate_base_tiles(chunk: ChunkData):

	var chunk_start = chunk.position * CHUNK_SIZE
	
	for x in range(CHUNK_SIZE):
		for y in range(CHUNK_SIZE):
			var pos = chunk_start + Vector2i(x, y)
			var variant = rng.randi_range(0, 2)  # 3 variations
			base_tilemap.set_cell(0, pos, 0, Vector2i(variant, 0))

func generate_details(chunk: ChunkData):
	var chunk_start = chunk.position * CHUNK_SIZE
	var attempts = 10
	
	while attempts > 0:
		attempts -= 1
		
		var pattern = select_weighted_pattern()
		var pos = Vector2i(
			chunk_start.x + rng.randi_range(0, CHUNK_SIZE - pattern.size.x),
			chunk_start.y + rng.randi_range(0, CHUNK_SIZE - pattern.size.y)
		)
		
		if is_valid_detail_position(pos, pattern):
			place_pattern(pos, pattern, chunk)

func select_weighted_pattern() -> PatternDetail:
	var total_weight = 0.0
	for pattern in pattern_details:
		total_weight += pattern.weight
	
	var random_value = rng.randf_range(0, total_weight)
	var current_weight = 0.0
	
	for pattern in pattern_details:
		current_weight += pattern.weight
		if random_value <= current_weight:
			return pattern
	
	return pattern_details[0]

func is_valid_detail_position(pos: Vector2i, pattern: PatternDetail) -> bool:
	# Check minimum distance from other details (2 tiles)
	for y in range(-2, pattern.size.y + 2):
		for x in range(-2, pattern.size.x + 2):
			var check_pos = pos + Vector2i(x, y)
			if detail_positions.has(tile_key(check_pos)):
				return false
	
	return true

func place_pattern(pos: Vector2i, pattern: PatternDetail, chunk: ChunkData):
	var flip_h = pattern.can_flip and rng.randf() < 0.5
	var flip_v = pattern.can_flip and rng.randf() < 0.5
	var rotate = pattern.can_rotate and rng.randi_range(0, 3)
	
	# Get the pattern data from the TileSet
	var pattern_coords = detail_tilemap.tile_set.get_pattern(pattern.pattern_id)
	
	# Apply the pattern
	detail_tilemap.set_pattern(0, pos, pattern_coords)
	
	# Record detail positions
	for y in range(pattern.size.y):
		for x in range(pattern.size.x):
			var tile_pos = pos + Vector2i(x, y)
			detail_positions[tile_key(tile_pos)] = true
	
	chunk.details.append({
		"pos": pos,
		"pattern": pattern,
		"flip_h": flip_h,
		"flip_v": flip_v,
		"rotate": rotate
	})

func world_to_chunk(world_pos: Vector2i) -> Vector2i:
	return Vector2i(
		floor(float(world_pos.x) / CHUNK_SIZE),
		floor(float(world_pos.y) / CHUNK_SIZE)
	)

func chunk_key(chunk_coords: Vector2i) -> String:
	return "%d,%d" % [chunk_coords.x, chunk_coords.y]

func tile_key(tile_coords: Vector2i) -> String:
	return "%d,%d" % [tile_coords.x, tile_coords.y]

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
	for chunk_key in chunks_to_remove:
		remove_chunk(chunk_key)
	
	# Generate new chunks
	initialize_visible_chunks(center_pos)

#func remove_chunk(chunk_key: String):
	#var chunk = active_chunks[chunk_key]
	#
	## Remove all details in the chunk
	#for detail in chunk.details:
		#var pos = detail.pos
		#var size = detail.pattern.size
		#for y in range(size.y):
			#for x in range(size.x):
				#var tile_pos = pos + Vector2i(x, y)
				#detail_positions.erase(tile_key(tile_pos))
				#detail_tilemap.erase_cell(0, tile_pos)
	#
	#active_chunks.erase(chunk_key)

func apply_chunk_details(chunk: ChunkData):
	# Apply the stored details to the tilemap
	for i in range(chunk.details.positions.size()):
		var pos = chunk.details.positions[i]
		var tile_index = chunk.details.tile_indices[i]
		detail_tilemap.set_cell(0, pos, tile_index, Vector2i.ZERO)

# Add this function to clear details when removing chunks
func remove_chunk(chunk_coords):
	var chunk = active_chunks[chunk_coords]
	if chunk:
		# Clear the details for this chunk
		for pos in chunk.details.positions:
			detail_tilemap.erase_cell(0, pos)
		active_chunks.erase(chunk_coords)

func generate_and_store_details(chunk: ChunkData):

	# Your detail generation logic here
	for x in range(CHUNK_SIZE):
		for y in range(CHUNK_SIZE):
			if rng.randf() < 0.1:  # 10% chance for a detail
				var world_pos = chunk.position + Vector2i(x, y)
				chunk.details.positions.append(world_pos)
				# Store the tile index for this detail
				chunk.details.tile_indices.append(rng.randi_range(0, 3))  # Adjust range based on your tileset
