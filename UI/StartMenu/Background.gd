extends ColorRect

func _ready():
	# Ensure the ColorRect fills the screen
	anchor_right = 1.0
	anchor_bottom = 1.0
	
	# Create material
	material = ShaderMaterial.new()
	material.shader = preload("res://Art/Shaders/start_menu_background.gdshader")
	
	# Set up shader parameters
	material.set_shader_parameter("base_color", Color(0.55, 0.1, 1, 1.0))  # Orange
	material.set_shader_parameter("static_color", Color(0.0, 0.0, 0.0, 1.0)) # Black
	
	# Optional: Adjust these parameters to fine-tune the effect
	material.set_shader_parameter("noise_scale", 50.0)
	material.set_shader_parameter("wave_speed", 1.0)
	material.set_shader_parameter("wave_frequency", 5.0)
	material.set_shader_parameter("wave_amplitude", 0.05)
	material.set_shader_parameter("pulse_speed", 0.5)
	material.set_shader_parameter("min_pulse_size", 0.1)
	material.set_shader_parameter("max_pulse_size", 0.2)
