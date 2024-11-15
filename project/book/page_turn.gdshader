shader_type spatial;

uniform vec3 front_color: source_color;
uniform vec3 back_color: source_color;
uniform vec3 bg_color: source_color;

uniform vec2 mouse_pos;
uniform vec2 pivot_pos;


vec2 midpoint(vec2 a, vec2 b) {
	float x = (a.x + b.x) / 2.0;
	float y = (a.y + b.y) / 2.0;
	return vec2(x, y);
}

vec2 rotated_around_point(vec2 a, vec2 p, float angle) {
	float x = (a.x - p.x) * cos(angle) - (a.y - p.y) * sin(angle) + p.x;
	float y = (a.y - p.y) * cos(angle) + (a.x - p.x) * sin(angle) + p.y;
	return vec2(x, y);
}

bool is_right_of_line(vec2 p, vec2 a, vec2 b) {
	return (b.x - a.x)*(p.y - a.y) - (b.y - a.y)*(p.x - a.x) < 0.0;
}

void fragment() {
	vec2 p1 = midpoint(mouse_pos, pivot_pos);
	vec2 p2 = rotated_around_point(pivot_pos, p1, 0.5 * PI);
	
	if (is_right_of_line(UV, p1, p2)) {
		ALBEDO = back_color;
	} else {
		ALBEDO = front_color;
	}
}