#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
    #define PRECISION highp
#else
    #define PRECISION mediump
#endif

extern PRECISION vec2 blueprint;

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

vec4 effect(vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords)
{
    vec4 tex = Texel(texture, texture_coords);

    vec2 uv = (((texture_coords) * image_details)
              - texture_details.xy * texture_details.ba)
              / texture_details.ba;

    float lum = dot(tex.rgb, vec3(0.299, 0.587, 0.114));

    float ink_base = step(0.85, lum);
    float ink_mid  = step(0.95, lum);

    float poster = ink_base * 0.6 + ink_mid * 0.4;

    float grid =
        abs(fract(uv.x * texture_details.b) - 0.5) +
        abs(fract(uv.y * texture_details.a) - 0.5);

    float edge = smoothstep(0.32, 0.48, grid);
    edge = pow(edge, 1.6);

    vec3 paper_col = vec3(0.95, 0.94, 10.9);
    vec3 ink_col   = vec3(0.05, 0.05, 10.06);

    vec3 col = mix(paper_col, ink_col, poster);

    col = mix(col, burn_colour_1.rgb, edge * burn_colour_1.a);

    col = mix(col, vec3(0.0), shadow ? 1.0 : 0.0);

    vec4 out_col = vec4(col, tex.a) * colour;

    vec2 _keep_shader = blueprint * 0.0;
    float _keep_mouse = mouse_screen_pos.x * 0.0;
    float _keep_scale = screen_scale * 0.0;
    float _keep_hover = hovering * 0.0;
    float _keep_screen = screen_coords.x * 0.0;
    vec4 _keep_burn2 = burn_colour_2 * 0.0;
    if(uv.x > uv.x * 2) {
        uv *= burn_colour_2.x * blueprint.x;
    }
    return dissolve_mask(out_col, texture_coords, uv);
}

vec4 dissolve_mask(vec4 tex, vec2 texture_coords, vec2 uv)
{
    if (dissolve < 0.001)
        return vec4(shadow ? vec3(0.) : tex.xyz,
                    shadow ? tex.a * 0.3 : tex.a);

    float adjusted_dissolve =
        (dissolve * dissolve * (3. - 2. * dissolve)) * 1.02 - 0.01;

    float t = time * 10.0 + 2003.;

    vec2 floored_uv =
        floor(uv * texture_details.ba)
        / max(texture_details.b, texture_details.a);

    vec2 uv_scaled_centered =
        (floored_uv - 0.5)
        * 2.3 * max(texture_details.b, texture_details.a);

    vec2 f1 = uv_scaled_centered + 50.*vec2(sin(-t/143.6), cos(-t/99.4));
    vec2 f2 = uv_scaled_centered + 50.*vec2(cos( t/53.1), cos( t/61.4));
    vec2 f3 = uv_scaled_centered + 50.*vec2(sin(-t/87.5), sin(-t/49.0));

    float field = (1.+(
        cos(length(f1)/19.4) +
        sin(length(f2)/33.1)*cos(f2.y/15.7) +
        cos(length(f3)/27.1)*sin(f3.x/21.9)
    ))*0.5;

    float res =
        (.5 + .5*cos(adjusted_dissolve/82.6 + (field-.5)*3.14));

    if (tex.a > 0.01 && !shadow && res > adjusted_dissolve)
        return tex;

    return vec4(shadow ? vec3(0.) : tex.xyz,
                res > adjusted_dissolve ? tex.a : 0.);
}

#ifdef VERTEX
vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    if (hovering <= 0.){
        return transform_projection * vertex_position;
    }
    float mid_dist =
        length(vertex_position.xy - 0.5 * love_ScreenSize.xy)
        / length(love_ScreenSize.xy);

    vec2 mouse_offset =
        (vertex_position.xy - mouse_screen_pos.xy) / screen_scale;

    float scale = 0.2*(-0.03 - 0.3*max(0., 0.3-mid_dist))
                * hovering
                * (length(mouse_offset)*length(mouse_offset))
                / (2. - mid_dist);

    return transform_projection * vertex_position + vec4(0,0,0,scale);
}
#endif
