shader_type canvas_item;
render_mode unshaded;

const vec2 OFFSETS[8] = {
	vec2(-0.71, -0.71), vec2(-1, 0), vec2(-0.71, 0.71), vec2(0, -1), vec2(0, 1), 
	vec2(0.71, -0.71), vec2(1, 0), vec2(0.71, 0.71)
};

uniform bool outline_enabled = false;
uniform float line_thickness : hint_range(0.0, 10.0);
uniform vec4 line_color : source_color = vec4(1.0);
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
	vec4 c = texture(screen_texture, SCREEN_UV);

	if (c.a > 0.0001) {
		c.rgb /= c.a;
	}

	if (outline_enabled) {
		vec2 size = line_thickness * SCREEN_PIXEL_SIZE;
		float outline = 0.0;

		for (int i = 0; i < OFFSETS.length(); i++) {
			vec2 coordinate_offset = SCREEN_UV + size * OFFSETS[i];
			outline += texture(screen_texture, coordinate_offset).a;
		}

		outline = sign(outline);
		COLOR = mix(c, line_color, outline - c.a);
	} else {
		COLOR = c;
	}
}