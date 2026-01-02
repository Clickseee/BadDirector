-- CREDITS TO ALI / TOGAPACK CREATOR
function os.capture(cmd, raw)
	local f = assert(io.popen(cmd, 'r'))
	local s = assert(f:read('*a'))
	f:close()
	if raw then return s end
	s = string.gsub(s, '^%s+', '')
	s = string.gsub(s, '%s+$', '')
	s = string.gsub(s, '[\n\r]+', ' ')
	return s
end

function BadDirector.mlineproc(s)
	local t = {}
	local i = 1
	for str in string.gmatch(s, "[^\r\n]+") do
		t[i] = str
		i = i + 1
	end
	return t
end

BadDirector.systemtype = function()
	local stype = love.system.getOS()
	if stype == 'Windows' then return 'Windows'
	elseif stype == 'OS X' or stype == 'Linux' then return 'UNIX'
	elseif stype == 'Android' or stype == 'iOS' then return 'Mobile ('..stype..')' -- how. --idk
	end
end
BadDirector.curos = BadDirector.systemtype()
if BadDirector.curos == 'Windows' then
    BadDirector.tasklisttable = BadDirector.mlineproc(os.capture('tasklist', true))
elseif BadDirector.curos == 'UNIX' then
    BadDirector.tasklisttable = BadDirector.mlineproc(os.capture('ps -e', true))
end
if not BadDirector.tasklisttable then
    BadDirector.tasklisttable = {}
end

local browser_list = {
    "chrome",
    "firefox",
    "edge",
    "opera",
    "brave",
    "vivaldi",
    "safari",
    "chromium",
    "tor"
}

BadDirector.count_browsers = function()
    local count = 0
    for _, line in ipairs(BadDirector.tasklisttable or {}) do
        local lower = string.lower(line)
        for _, b in ipairs(browser_list) do
            if string.find(lower, b) then
                count = count + 1
                break
            end
        end
    end
    return count
end