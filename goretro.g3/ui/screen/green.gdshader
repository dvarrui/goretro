shader_type canvas_item;

// Umbral ajustable
uniform float threshold : hint_range(0.0, 1.0) = 0.1; 

void fragment() {
    vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV);
    // Calcula la luminancia
    float luminance = dot(color.rgb, vec3(0.299, 0.587, 0.114));
    
    // Binarización: Si la luminancia es mayor al umbral, es verde; si no, negro.
    // vec3(0.0, 1.0, 0.0) es verde puro.
    vec3 green_color = vec3(0.0, 1.0, 0.0);
	vec3 final_color = vec3(0.0, 0.0, 0.0);
	if (luminance > threshold) { final_color = green_color; }
	
    COLOR = vec4(final_color, color.a);
}