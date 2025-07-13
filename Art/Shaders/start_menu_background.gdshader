shader_type canvas_item;

// Noise and wave parameters
uniform float noise_scale = 50.0;
uniform float wave_speed = 1.0;
uniform float wave_frequency = 5.0;
uniform float wave_amplitude = 0.005;
uniform vec2 wave_direction = vec2(1.0, 0.5);

// Colors
uniform vec4 base_color : source_color = vec4(.1, 0.1, 1, 1.0); // Orange
uniform vec4 static_color : source_color = vec4(0.0, 0.0, 0.0, 1.0); // Black

// Random function
float random(vec2 uv) {
    return fract(sin(dot(uv, vec2(12.9898, 78.233))) * 43758.5453123);
}

// 2D Noise based on Morgan McGuire's work
float noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);

    // Sharper interpolation for less connection
    vec2 u = f * f * f * (f * (f * 6.0 - 15.0) + 10.0);

    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));

    return mix(mix(a, b, u.x),
              mix(c, d, u.x), u.y);
}

// Modified FBM for less connected patterns
float fbm(vec2 uv) {
    float value = 0.0;
    float amplitude = 0.6;  // Increased initial amplitude
    float frequency = 1.0;

    // Reduced layers for less connection
    for(int i = 0; i < 10; i++) {
        value += amplitude * noise(frequency * uv);
        frequency *= 2.5;   // Increased frequency jump
        amplitude *= 0.4;   // Steeper amplitude drop
    }

    return value;
}

// Wave distortion
vec2 wave_distortion(vec2 uv, float time) {
    vec2 wave = wave_direction * sin(time * wave_speed + uv.x * wave_frequency) * wave_amplitude;
    return uv + wave;
}

void fragment() {
    // Apply wave distortion to UV with faster movement
    vec2 distorted_uv = wave_distortion(UV, TIME * .1);

    // Generate noise pattern with faster movement
    float noise_value = fbm(distorted_uv * noise_scale * 1.5 + TIME * 1.0);  // Increased time factor

    // Add variation with faster secondary movement
    noise_value *= fbm(distorted_uv * noise_scale * .5 - TIME * 0.4);

    // Sharper contrast for more distinct patterns
    //noise_value = smoothstep(0.35, 0.45, noise_value);  // Narrowed smoothstep range

    // Mix colors with high contrast
    vec4 final_color = mix(base_color, static_color, noise_value * 0.9);

    COLOR = final_color;
}