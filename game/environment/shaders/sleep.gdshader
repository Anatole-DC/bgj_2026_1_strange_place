shader_type canvas_item;

// Control parameters
uniform float sleep_intensity : hint_range(0.0, 1.0) = 0.0;
uniform float vignette_strength : hint_range(0.0, 1.0) = 0.5;
uniform float vignette_softness : hint_range(0.1, 2.0) = 0.8;
uniform vec3 darkness_color : source_color = vec3(0.0, 0.0, 0.0); // Pure black
uniform float pulse_speed = 1.0;
uniform float pulse_amount : hint_range(0.0, 0.3) = 0.1;

void fragment() {
	vec2 uv = UV;
	
	// Calculate distance from center for vignette
	vec2 center = vec2(0.5, 0.5);
	float dist = distance(uv, center);
	
	// Create vignette effect
	float vignette = smoothstep(vignette_softness, vignette_softness - 0.5, dist);
	vignette = mix(1.0, vignette, vignette_strength);
	
	// Add subtle pulsing like eyelids getting heavy
	float pulse = sin(TIME * pulse_speed) * pulse_amount;
	float darkness = sleep_intensity + (pulse * sleep_intensity);
	darkness = clamp(darkness, 0.0, 1.0);
	
	// Combine vignette with darkness
	float final_darkness = darkness * vignette;
	
	// Output darkened color
	COLOR = vec4(darkness_color, final_darkness);
}