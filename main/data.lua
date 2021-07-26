local M = {}
local json = require('main.json')

M.STATE_START = 1
M.STATE_GAME = 2
M.STATE_GAMEOVER = 3

M.state = M.STATE_START

local savefile_path = sys.get_save_file(string.gsub(sys.get_config('project.title'), '%s+', ''), 'save_file')
local loaded = sys.load(savefile_path)

M.sd = {
	best_score = loaded.best_score or 0
}

M.bg_color = vmath.vector4(238/255, 238/255, 238/255, 1)
M.color_one = vmath.vector4(233/255, 70/255, 75/255, 1)
M.color_two = vmath.vector4(53/255, 53/255, 65/255, 1)

function M.save()
	if sys.save(savefile_path, M.sd) then
		print('save successful')
	else
		print('save failed')
	end
end

function M.distance_between(a, b)
	if (type(a) == 'number' and type(b) == 'number') then
		local distance = math.abs(a - b)
		return distance
	elseif (type(a) == 'userdata' and type(b) == 'userdata') then
		local x_factor = a.x - b.x
		local y_factor = a.y - b.y
		local distance = math.sqrt((x_factor * x_factor) + (y_factor * y_factor))
		return distance
	else
		print('distance_between: a and b not the correct type')
		return nil
	end
end

function M.duration(speed, a, b)
	local distance = M.distance_between(a, b)
	local duration = 0.1 * distance / speed
	return duration
end

return M