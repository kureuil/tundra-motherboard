local class = require 'utils/middleclass'

local Entity = class 'Entity'
function Entity:initialize()
	self.x = 0
	self.y = 0
	self.spawned = false
end

function Entity:update(dt)
end

function Entity:draw()
end

return Entity