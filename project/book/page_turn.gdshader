shader_type spatial;

uniform vec3 front_color: source_color;
uniform vec3 back_color: source_color;
uniform vec3 bg_color: source_color;

uniform vec2 mouse_pos;
uniform vec2 pivot_pos;
uniform vec2 sticky_pos1;
uniform vec2 sticky_pos2;


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

float two_point_line(float x, vec2 a, vec2 b) {
	float m = (b.y - a.y) / (b.x - a.x);
	float c = a.y - m * a.x;
	
	return m * x + c;
}

float dist_to_line(vec2 p, vec2 a, vec2 b) {
	float m1 = (b.y - a.y) / (b.x - a.x);
	float c1 = a.y - m1 * a.x;
	
	float m2 = -1.0 / m1;
	float c2 = p.y - m2 * p.x;
	
	float x = (c2 - c1) / (m1 - m2);
	float y = m1 * x + c1;
	
	return distance(p, vec2(x, y));
}

vec2 set_length(vec2 p, float dist) {
	return normalize(p) * dist; 
}

bool line_intersects_above_point(vec2 m, vec2 p, vec2 s) {
	return (m.y - s.y)*(m.y - s.y) + (m.x - s.x)*(m.x - s.x) > (p.x - s.x)*(p.x - s.x) + (p.y - s.y)*(p.y - s.y); 
}

void fragment() {
	vec2 target_pos = mouse_pos;
	if (distance(sticky_pos1, target_pos) > distance(sticky_pos1, pivot_pos)) {
		float dist = distance(sticky_pos1, pivot_pos);
		target_pos = set_length(target_pos - sticky_pos1, dist) + sticky_pos1;
	}
	
	if (distance(sticky_pos2, target_pos) > distance(sticky_pos2, pivot_pos)) {
		float dist = distance(sticky_pos2, pivot_pos);
		target_pos = set_length(target_pos - sticky_pos2, dist) + sticky_pos2;
	}
	
	vec2 mp = midpoint(target_pos, pivot_pos);
	vec2 p1 = rotated_around_point(target_pos, mp, PI / 2.0);
	vec2 p2 = rotated_around_point(pivot_pos, mp, PI / 2.0);

	if (is_right_of_line(UV, p1, p2)) {
		ALBEDO = back_color;
	} else {
		ALBEDO = front_color;
	}
}