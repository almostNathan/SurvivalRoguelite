# BackdropManager.gd
extends Node2D

# Constants for chunk management
const CHUNK_SIZE = 512  # Size of each chunk in pixels
const CHUNKS_VISIBLE = 3  # How many chunks visible in each direction from player

# Preloaded resources
@export var ground_textures: Array[Texture2D]  # Array of ground variation textures
@export var set_pieces: Array[PackedScene]  # Array of set piece scenes
@export var set_piece_weights: Array[float]  # Spawn weights for each set piece

# Dictionary to track active chunks and their contents
var active_chunks = {}  # Format: "x,y": ChunkData
var rng = RandomNumberGenerator.new()

# Class to hold chunk data
class ChunkData:
	var position: Vector2
	var ground_instance: Sprite2D
	var set_pieces: Array
	
	func _init(pos: Vector2):
		position = pos
		set_pieces = []

func _ready():
	rng.randomize()
	initialize_visible_chunks(Vector2.ZERO)

func initialize_visible_chunks(player_pos: Vector2):
	var chunk_coords = world_to_chunk(player_pos)
	
	# Generate chunks in view distance
	for x in range(-CHUNKS_VISIBLE, CHUNKS_VISIBLE + 1):
		for y in range(-CHUNKS_VISIBLE, CHUNKS_VISIBLE + 1):
			var chunk_pos = Vector2(chunk_coords.x + x, chunk_coords.y + y)
			generate_chunk(chunk_pos)

func generate_chunk(chunk_coords: Vector2) -> void:
	if active_chunks.has(chunk_key(chunk_coords)):
		return
		
	var chunk = ChunkData.new(chunk_coords * CHUNK_SIZE)
	
	# Create ground with variations
	chunk.ground_instance = create_ground_variation(chunk.position)
	add_child(chunk.ground_instance)
	
	# Generate set pieces for this chunk
	generate_set_pieces_for_chunk(chunk)
	
	active_chunks[chunk_key(chunk_coords)] = chunk

func create_ground_variation(pos: Vector2) -> Sprite2D:
	var ground = Sprite2D.new()
	ground.texture = ground_textures[rng.randi() % ground_textures.size()]
	ground.position = pos
	return ground

func generate_set_pieces_for_chunk(chunk: ChunkData) -> void:
	# Number of attempts to place set pieces in this chunk
	var num_attempts = rng.randi_range(3, 7)
	
	for _i in range(num_attempts):
		# Select a random set piece based on weights
		var piece_index = select_weighted_piece()
		var piece_scene = set_pieces[piece_index]
		
		# Random position within chunk
		var pos = Vector2(
			chunk.position.x + rng.randf_range(0, CHUNK_SIZE),
			chunk.position.y + rng.randf_range(0, CHUNK_SIZE)
		)
		
		# Check for minimum spacing
		if is_position_valid(pos, chunk):
			var piece = piece_scene.instantiate()
			piece.position = pos
			# Random rotation
			piece.rotation = rng.randf_range(0, PI * 2)
			add_child(piece)
			chunk.set_pieces.append(piece)

func select_weighted_piece() -> int:
	var total_weight = 0.0
	for weight in set_piece_weights:
		total_weight += weight
	
	var random_value = rng.randf_range(0, total_weight)
	var current_weight = 0.0
	
	for i in range(set_piece_weights.size()):
		current_weight += set_piece_weights[i]
		if random_value <= current_weight:
			return i
	
	return 0

func is_position_valid(pos: Vector2, chunk: ChunkData) -> bool:
	# Define minimum spacing
	const MIN_SPACING = 100.0
	
	# Check distance from existing pieces in chunk
	for piece in chunk.set_pieces:
		if pos.distance_to(piece.position) < MIN_SPACING:
			return false
	
	return true

func world_to_chunk(world_pos: Vector2) -> Vector2:
	return Vector2(
		floor(world_pos.x / CHUNK_SIZE),
		floor(world_pos.y / CHUNK_SIZE)
	)

func chunk_key(chunk_coords: Vector2) -> String:
	return "%d,%d" % [chunk_coords.x, chunk_coords.y]

# Call this from your main game node when the player moves
func update_chunks(player_pos: Vector2) -> void:
	var current_chunk = world_to_chunk(player_pos)
	
	# Generate new chunks that have come into view
	for x in range(-CHUNKS_VISIBLE, CHUNKS_VISIBLE + 1):
		for y in range(-CHUNKS_VISIBLE, CHUNKS_VISIBLE + 1):
			var check_chunk = Vector2(current_chunk.x + x, current_chunk.y + y)
			if not active_chunks.has(chunk_key(check_chunk)):
				generate_chunk(check_chunk)
