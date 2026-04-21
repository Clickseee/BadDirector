BadDirector_crt_glitch = 0 -- shoutout to Alex (Mayhem) for all of these
BadDirector_crt_noise = 0
BadDirector_crt_intensity = 0
glitched_intensity = 0

function BadDirector_get_crt_vals(key)
    if #SMODS.find_mod('Cryptid') ~= 0 and key == 'glitch' then
        return glitched_intensity
    end

    if #SMODS.find_mod('mayhem') == 0 then
        if key == 'glitch' then
            return BadDirector_crt_glitch
        elseif key == 'noise' then
            return BadDirector_crt_noise
        elseif key == 'intensity' then
            return BadDirector_crt_intensity
        end
    else
        if key == 'glitch' then
            return transcendence_glitch
        elseif key == 'noise' then
            return transcendence_noise
        elseif key == 'intensity' then
            return transcendence_crt
        end
    end
end


function BadDirector_set_crt_vals(key, num)
    if #SMODS.find_mod('Cryptid') ~= 0 and key == 'glitch' then
        glitched_intensity = num
        return
    end

    if #SMODS.find_mod('mayhem') == 0 then
        if key == 'glitch' then
            BadDirector_crt_glitch = num
        elseif key == 'noise' then
            BadDirector_crt_noise = num
        elseif key == 'intensity' then
            BadDirector_crt_intensity = num
        end
    else
        if key == 'glitch' then
            transcendence_glitch = num
        elseif key == 'noise' then
            transcendence_noise = num
        elseif key == 'intensity' then
            transcendence_crt = num
        end
    end
end
