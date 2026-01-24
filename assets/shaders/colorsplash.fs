#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
    #define PRECISION highp
#else
    #define PRECISION mediump
#endif

extern PRECISION vec2 colorsplash;

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

    vec2 uv = (((texture_coords)*(image_details)) - texture_details.xy*texture_details.ba)
              / texture_details.ba;

    vec3 col = tex.rgb;

    float angle = atan(uv.y - 0.5, uv.x - 0.5);
    float radius = length(uv - 0.5);

    float shimmer =
        sin(angle * 6.0 + time * 0.6) +
        cos(radius * 18.0 - time * 0.8);
    shimmer = shimmer * 0.5 + 0.5;

    vec3 iridescent = vec3(
        0.6 + 0.4 * sin(time + angle * 2.0),
        0.6 + 0.4 * sin(time + angle * 2.0 + 2.1),
        0.6 + 0.4 * sin(time + angle * 2.0 + 4.2)
    );

    col = mix(col, col * iridescent, shimmer * 0.35);

    float edge = smoothstep(0.45, 0.9, radius);
    col += edge * vec3(0.15, 0.18, 0.22);

    vec4 out_col = vec4(col, tex.a) * colour;

    vec2 _keep_shader = colorsplash * 0.0;
    float _keep_mouse = mouse_screen_pos.x * 0.0;
    float _keep_scale = screen_scale * 0.0;
    float _keep_hover = hovering * 0.0;
    float _keep_screen = screen_coords.x * 0.0;
    if(uv.x > uv.x * 2) {
        uv *= burn_colour_2.x * colorsplash.x;
    }
    return dissolve_mask(out_col, texture_coords, uv);
}

vec4 dissolve_mask(vec4 tex, vec2 texture_coords, vec2 uv)
{
    if (dissolve < 0.001) {
        return vec4(shadow ? vec3(0.) : tex.xyz,
                    shadow ? tex.a * 0.3 : tex.a);
    }

    float adjusted_dissolve =
        (dissolve*dissolve*(3.-2.*dissolve))*1.02 - 0.01;

    float t = time * 10.0 + 2003.;

    vec2 floored_uv =
        floor(uv * texture_details.ba)
        / max(texture_details.b, texture_details.a);

    vec2 uv_scaled_centered =
        (floored_uv - 0.5)
        * 2.3 * max(texture_details.b, texture_details.a);

    vec2 f1 = uv_scaled_centered + 50. * vec2(sin(-t / 143.6), cos(-t / 99.4));
    vec2 f2 = uv_scaled_centered + 50. * vec2(cos( t / 53.1),  cos( t / 61.4));
    vec2 f3 = uv_scaled_centered + 50. * vec2(sin(-t / 87.5), sin(-t / 49.0));

    float field = (1. + (
        cos(length(f1) / 19.4)
      + sin(length(f2) / 33.1) * cos(f2.y / 15.7)
      + cos(length(f3) / 27.1) * sin(f3.x / 21.9)
    )) * 0.5;

    vec2 borders = vec2(0.2, 0.8);

    float res =
        (.5 + .5 * cos(adjusted_dissolve / 82.6 + (field - .5) * 3.14))
        - max(0., floored_uv.x - borders.y) * (5. + 5.*dissolve) * dissolve
        - max(0., floored_uv.y - borders.y) * (5. + 5.*dissolve) * dissolve
        - max(0., borders.x - floored_uv.x) * (5. + 5.*dissolve) * dissolve
        - max(0., borders.x - floored_uv.y) * (5. + 5.*dissolve) * dissolve;

    if (tex.a > 0.01 && burn_colour_1.a > 0.01 && !shadow &&
        res < adjusted_dissolve + 0.8*(0.5-abs(adjusted_dissolve-0.5)) &&
        res > adjusted_dissolve)
    {
        if (res < adjusted_dissolve + 0.5*(0.5-abs(adjusted_dissolve-0.5)))
            tex.rgba = burn_colour_1.rgba;
        else if (burn_colour_2.a > 0.01)
            tex.rgba = burn_colour_2.rgba;
    }

    return vec4(
        shadow ? vec3(0.) : tex.xyz,
        res > adjusted_dissolve ? (shadow ? tex.a*0.3 : tex.a) : 0.
    );
}

#ifdef VERTEX
vec4 position(mat4 transform_projection, vec4 vertex_position)
{
    if (hovering <= 0.)
        return transform_projection * vertex_position;

    float mid_dist =
        length(vertex_position.xy - 0.5 * love_ScreenSize.xy)
        / length(love_ScreenSize.xy);

    vec2 mouse_offset =
        (vertex_position.xy - mouse_screen_pos.xy) / screen_scale;

    float scale =
        0.2 * (-0.03 - 0.3 * max(0., 0.3 - mid_dist))
        * hovering
        * dot(mouse_offset, mouse_offset)
        / (2. - mid_dist);

    return transform_projection * vertex_position + vec4(0, 0, 0, scale);
}
#endif
