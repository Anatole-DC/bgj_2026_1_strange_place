shader_type canvas_item;

// Control parameters
uniform float fog_intensity : hint_range(0.0, 1.0) = 0.5;
uniform vec3 fog_color : source_color = vec3(0.2, 0.4, 0.1); // Sickly green
uniform float fog_speed = 0.3;
uniform float fog_scale = 3.0;
uniform float distortion_strength = 0.15;

// Noise function for organic movement
float noise(vec2 uv) {
    return fract(sin(dot(uv, vec2(12.9898, 78.233))) * 43758.5453);
}

// Smooth noise
float smooth_noise(vec2 uv) {
    vec2 i = floor(uv);
    vec2 f = fract(uv);
    f = f * f * (3.0 - 2.0 * f);
    
    float a = noise(i);
    float b = noise(i + vec2(1.0, 0.0));
    float c = noise(i + vec2(0.0, 1.0));
    float d = noise(i + vec2(1.0, 1.0));
    
    return mix(mix(a, b, f.x), mix(c, d, f.x), f.y);
}

// Fractal Brownian Motion for layered fog
float fbm(vec2 uv) {
    float value = 0.0;
    float amplitude = 0.5;
    
    for(int i = 0; i < 4; i++) {
        value += amplitude * smooth_noise(uv);
        uv *= 2.0;
        amplitude *= 0.5;
    }
    
    return value;
}

void fragment() {
    vec2 uv = UV;
    
    // Animate the fog
    float time_offset = TIME * fog_speed;
    vec2 animated_uv = uv * fog_scale + vec2(time_offset * 0.1, time_offset * 0.05);
    
    // Create layered fog with different speeds
    float fog1 = fbm(animated_uv);
    float fog2 = fbm(animated_uv * 1.3 + vec2(time_offset * 0.15, -time_offset * 0.08));
    
    // Combine fog layers
    float fog_pattern = (fog1 + fog2) * 0.5;
    
    // Add some distortion for unsettling movement
    vec2 distortion = vec2(
        fbm(uv * 2.0 + TIME * 0.2) - 0.5,
        fbm(uv * 2.0 + TIME * 0.25 + vec2(100.0, 100.0)) - 0.5
    ) * distortion_strength;
    
    fog_pattern = fbm((uv + distortion) * fog_scale);
    
    // Apply intensity curve for more dramatic effect
    float fog_alpha = pow(fog_pattern, 1.5) * fog_intensity;
    
    // Add pulsing effect for breathing/living feeling
    float pulse = sin(TIME * 1.5) * 0.1 + 0.9;
    fog_alpha *= pulse;
    
    // Output only the fog with transparency
    COLOR = vec4(fog_color, fog_alpha);
}