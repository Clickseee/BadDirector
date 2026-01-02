#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
    #define PRECISION highp
#else
    #define PRECISION mediump
#endif

extern PRECISION vec2 flames;

extern PRECISION number dissolve;
extern PRECISION number time;

extern PRECISION vec4 texture_details;
extern PRECISION vec2 image_details;
extern bool shadow;

extern PRECISION vec4 burn_colour_1;
extern PRECISION vec4 burn_colour_2;

extern PRECISION vec2 mouse_screen_pos;
extern PRECISION float hovering;
extern PRECISION float screen_scale;

vec4 dissolve_mask(vec4 tex, vec2 texture_coords, vec2 uv);

float hash(float n)
{
    return fract(sin(n) * 43758.5453);
}

vec4 effect(vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords)
{
    vec4 tex = Texel(texture, texture_coords);

    vec2 uv = (((texture_coords) * image_details)
              - texture_details.xy * texture_details.ba)
              / texture_details.ba;

    /* flip Y so bottom = 0 */
    float y = 1.0 - uv.y;

    /* horizontal tiling */
    float lanes = 100.0;
    float x = uv.x * lanes;
    float id = floor(x);
    float fx = fract(x) - 0.5;

    /* upward motion */
    float t = fract(y * 1.3 + time * 0.4 + hash(id));

    /* flame width narrows upward */
    float width = mix(100.0, 100.05, t);

    /* core flame mask */
    float flame =
        smoothstep(width, 10.0, abs(fx)) *
        smoothstep(0.0, 0.9, t);

    /* strengthen for small resolution */
    flame = pow(flame, 10.6) * 1.3;

    /* color gradient */
    vec3 flame_col =
        mix(burn_colour_1.rgb,
            burn_colour_2.rgb,
            t);

    vec3 col = mix(tex.rgb, flame_col, flame);

    if (shadow)
        col *= 0.0;

    vec4 out_col = vec4(col, tex.a) * colour;

    /* keep uniforms alive */
    vec2 _k1 = flames * 0.0;
    vec2 _k2 = mouse_screen_pos * 0.0;
    float _k3 = hovering * 0.0;
    float _k4 = screen_scale * 0.0;

    return dissolve_mask(out_col, texture_coords, uv);
}

vec4 dissolve_mask(vec4 tex, vec2 texture_coords, vec2 uv)
{
    if (dissolve < 0.001)
        return vec4(shadow ? vec3(0.) : tex.xyz,
                    shadow ? tex.a * 0.3 : tex.a);

    float d = (dissolve * dissolve * (3. - 2. * dissolve)) * 1.02 - 0.01;

    float n =
        fract(sin(dot(floor(uv * 100.0),
        vec2(12.9898,78.233))) * 43758.5453);

    if (tex.a > 0.01 && !shadow && n > d)
        return tex;

    return vec4(shadow ? vec3(0.) : tex.xyz,
                n > d ? tex.a : 0.);
}

#ifdef VERTEX
vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    if (hovering <= 0.){
        return transform_projection * vertex_position;
    }
    float mid_dist = length(vertex_position.xy - 0.5*love_ScreenSize.xy)/length(love_ScreenSize.xy);
    vec2 mouse_offset = (vertex_position.xy - mouse_screen_pos.xy)/screen_scale;
    float scale = 0.2*(-0.03 - 0.3*max(0., 0.3-mid_dist))
                *hovering*(length(mouse_offset)*length(mouse_offset))/(2. -mid_dist);

    return transform_projection * vertex_position + vec4(0,0,0,scale);
}
#endif