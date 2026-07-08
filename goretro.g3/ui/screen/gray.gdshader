shader_type canvas_item;

uniform float noise_strength : hint_range(0.0, 0.5) = 0.45;
uniform float scanline_strength : hint_range(0.0, 1.0) = 0.3;
uniform float scanline_count : hint_range(0.0, 1080.0) = 100.0;
uniform float dot_size : hint_range(0.0, 10.0) = 4.0;

void fragment() {
    vec2 uv = SCREEN_UV;
    vec3 color = texture(SCREEN_TEXTURE, uv).rgb;
    
    // Luminancia
    float gray = dot(color, vec3(0.299, 0.587, 0.114));
    
    // Ruido blanco
    float random = fract(sin(dot(UV, vec2(12.9898, 78.233))) * 43758.5453);
    float grain = (random - 0.5) * noise_strength;
    vec3 final_color = vec3(gray + grain);
    
    // Efecto de Scanlines
    float scanline = sin(uv.y * scanline_count * 3.14159) * scanline_strength;
    final_color -= scanline;
    
    // Efecto de Puntos (Dot Mask)
    float pixel_x = mod(uv.x * SCREEN_PIXEL_SIZE.x / dot_size, 2.0);
    float pixel_y = mod(uv.y * SCREEN_PIXEL_SIZE.y / dot_size, 2.0);
    
    if (pixel_x > 1.0 && pixel_y > 1.0) {
        final_color *= 0.9;
    }
    
    COLOR = vec4(final_color, 1.0);
}