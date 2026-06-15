vec4 effect(vec4 colour, Image texture, vec2 tc, vec2 screen_coords)
{
    return Texel(texture, vec2(tc.x, 1.0 - tc.y)) * colour;
}