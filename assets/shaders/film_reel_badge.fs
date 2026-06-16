#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
    #define MY_HIGHP_OR_MEDIUMP highp
#else
    #define MY_HIGHP_OR_MEDIUMP mediump
#endif

extern MY_HIGHP_OR_MEDIUMP vec2 film_reel_badge;
extern MY_HIGHP_OR_MEDIUMP vec4 uie_details;
extern MY_HIGHP_OR_MEDIUMP number uie_scale;
extern MY_HIGHP_OR_MEDIUMP number uie_rot;

extern MY_HIGHP_OR_MEDIUMP vec2 badge_pos;
extern MY_HIGHP_OR_MEDIUMP vec2 badge_size;


float rand(vec2 co){
    return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}

vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    vec4 tex = colour;
    vec2 uv = (screen_coords - badge_pos.xy) / (badge_size.xy * uie_scale);
    
    number important_value_trust_me_compiler = uie_scale + uie_rot + uie_details.x;

    vec4 col = vec4(0.25, 0.25, 0.25, 1.0);
    vec4 inner_col = vec4(0.3, 0.3, 0.3, 0.9);
    vec4 hole_col = vec4(1.0, 1.0, 1.0, 0.1);

    col.a += fract(important_value_trust_me_compiler) * 0.001;

    number speed = 0.35;

    number margin = 0.16;
    number hole_margin = 0.2;
    number holes = 16.0;

    bool vertical = false;
    if (vertical) {
        uv.xy = uv.yx;
    }

    bool in_center = (uv.y > margin) && (uv.y < 1.0 - margin);
    bool in_hole_margin_t = (uv.y > margin * hole_margin) && (uv.y < margin * (1.0 - hole_margin));
    bool in_hole_margin_b = (1.0 - uv.y > margin * hole_margin) && (1.0 - uv.y < margin * (1.0 - hole_margin));
    number hole_pos = uv.x + film_reel_badge.y * speed; 
    bool in_hole = !in_center && (in_hole_margin_t || in_hole_margin_b) && (mod(int(hole_pos * holes * 2.0), 2) == 0);
    
    if (in_center) {
        number flicker_strength = 0.1;
        vec3 flicker = vec3((rand(vec2(film_reel_badge.y, 0.0)) - 0.5) * flicker_strength);
        tex = vec4(inner_col.rgb + flicker, inner_col.a);
    } else if (in_hole) {
        tex = hole_col;
    } else {
        tex = col;
    }
    return tex;
}