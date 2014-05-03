local class      = require 'utils/middleclass'
local TileEntity = require 'entities/tileentity'

local Checkpoint = class('Checkpoint', TileEntity)

function Checkpoint:initialize()
	TileEntity.initialize(self)
	self.is_blocking = false
	print("Checkpoint init")
end

function Checkpoint:update(dt)
	print("Checkpoint Update")
	if map.player:getGridX() == self:getGridX() and map.player:getGridY() == self:getGridY() then
		map:nextScreen()
	end
end

function Checkpoint:draw()
	local r, g, b, a = love.graphics.getColor()
	love.graphics.setColor(100, 0, 0, 100)
	love.graphics.rectangle("fill", self.x, self.y + hud_height, map.tile_size, map.tile_size)
	love.graphics.setColor(r, g, b, a)
end

return Checkpoint