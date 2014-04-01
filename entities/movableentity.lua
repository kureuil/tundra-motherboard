local class  = require 'utils/middleclass'
local Entity = require 'entities/entity'

local MovableEntity = class('MovableEntity', Entity)
function MovableEntity:initialize()
	Entity:initialize(self)
	self.dest_x    = 0
	self.dest_y    = 0
	self.is_moving = false
	self.speed     = 10
end

function MovableEntity:moveTo(shift_x, shift_y)
	if self:canMoveTo(self.x + shift_x, self.y + shift_y) then
		self.dest_x = self.x + shift_x
		self.dest_y = self.y + shift_y
	end
end

function MovableEntity:canMoveTo(x, y)
	local canMove = true

	return canMove
end

return MovableEntity