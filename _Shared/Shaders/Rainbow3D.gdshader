shader_type canvas_item;
// Stolen from
// https://godotshaders.com/shader/hsv-adjustment/
vec3 hsv2rgb(vec3 c) {
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void vertex() {
	vec2 new_verts = VERTEX;
	vec2 moved_uvs = (UV + 1.0)/2.0;
	new_verts.x += sin(TIME * 25.0 * (moved_uvs.y)) * 10.0;
	VERTEX = new_verts;
}

void fragment() {
	vec4 text = texture(TEXTURE, UV);
	float color = TIME + UV.x;
	vec3 base_hsv = vec3(color,1,1);
	vec3 new_hsv = hsv2rgb(base_hsv); 
	COLOR = vec4(new_hsv, text.a);
}