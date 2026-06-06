//Shader by Lily.feili
extern vec2 center_pos; //pixel position to center the flashlight around
extern float dist; //how many pixels away for it to be at 0.5 intensity


// This is what actually changes the look of card
vec4 effect( vec4 colour, Image texture, vec2 tc, vec2 screen_coords )
{
    vec4 tex = Texel(texture, tc);
    tex.rgb *= ((dist - distance(center_pos, screen_coords))/dist);

    return tex;
}



#ifdef VERTEX
vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    return transform_projection * vertex_position;
}
#endif