shader_type canvas_item;

// Parámetros ajustables desde el Inspector
uniform float scanline_strength : hint_range(0.0, 1.0) = 0.5;
uniform float scanline_count : hint_range(0.0, 1080.0) = 50.0;
uniform float dot_size : hint_range(0.0, 10.0) = 2.0;

void fragment() {
    vec2 uv = SCREEN_UV;
    
    // 1. Obtener color base
    vec3 color = texture(SCREEN_TEXTURE, uv).rgb;
    
    // 2. Efecto de Scanlines (Líneas horizontales)
    float scanline = sin(uv.y * scanline_count * 3.14159) * scanline_strength;
    color -= scanline;
    
    // 3. Efecto de Puntos (Dot Mask / Máscara de rejilla)
    // Usamos el residuo de la posición para crear un patrón de cuadrícula
    float pixel_x = mod(uv.x * SCREEN_PIXEL_SIZE.x / dot_size, 2.0);
    float pixel_y = mod(uv.y * SCREEN_PIXEL_SIZE.y / dot_size, 2.0);
    
    // Oscurecemos ligeramente ciertos puntos para simular la rejilla de fósforo
    if (pixel_x > 1.0 && pixel_y > 1.0) {
        color *= 0.9;
    }
    
    COLOR = vec4(color, 1.0);
}