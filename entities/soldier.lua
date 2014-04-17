local class         = require 'utils/middleclass'
local MovableEntity = require 'entities/movableentity'

local Soldier = class('Soldier', MovableEntity)

function Soldier:initialize()

end

function Soldier:update(dt)
	-- body
end

function Soldier:draw()
	local r, g, b, a = love.graphics.getColor()
	love.graphics.setColor(255, 0, 0)
	love.graphics.rectangle("fill", self.x, self.y + hud_height, map.tile_size, map.tile_size)
	love.graphics.setColor(r, g, b, a)
end

return Soldier