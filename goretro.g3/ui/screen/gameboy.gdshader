
shader_type canvas_item;

uniform float grid_size = 2.5; 
uniform float grid_strength = 0.4;

void fragment() {
    // 1. Color base
    vec3 color = texture(SCREEN_TEXTURE, SCREEN_UV).rgb;
    //float gray = dot(color, vec3(0.299, 0.587, 0.114));
    float gray = dot(color, vec3(0.99, 0.587, 0.114));
    
    // Paleta Game Boy
    vec3 color0 = vec3(0.06, 0.17, 0.06); 
    vec3 color1 = vec3(0.18, 0.35, 0.18); 
    vec3 color2 = vec3(0.40, 0.55, 0.20); 
    vec3 color3 = vec3(0.60, 0.70, 0.20);
    
    // 3. Cuantización
    vec3 final_color;
    if (gray < 0.25) { final_color = color0; }
    else if (gray < 0.5) { final_color = color1; }
    else if (gray < 0.75) { final_color = color2; }
    else { final_color = color3; }
    
    // Grid fijo (basado en el tamaño de la pantalla)
    // Usamos SCREEN_PIXEL_SIZE.x y .y directamente
    float pixel_x = mod(SCREEN_UV.x / (SCREEN_PIXEL_SIZE.x * grid_size), 2.0);
    float pixel_y = mod(SCREEN_UV.y / (SCREEN_PIXEL_SIZE.y * grid_size), 2.0);
    
    // Si el cálculo da menor a 1.0, aplicamos el tono claro
    if (pixel_x < 1.0 || pixel_y < 1.0) {
        final_color = mix(final_color, color3, grid_strength);
    }
    
    COLOR = vec4(final_color, 1.0);
}