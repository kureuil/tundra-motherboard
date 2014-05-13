local class         = require 'utils/middleclass'
local MovableEntity = require 'entities/movableentity'

local Soldier = class('Soldier', MovableEntity)

-- Soldat, actuellement assimilé à une plante verte servant juste à décorer.
function Soldier:initialize()
	self.vision = {}
end

function Soldier:update(dt)
	local x = self:getGridX()
	local y = self:getGridY()
	
	if self.direction == 0 then
		table.insert(self.vision, {x = x, y = y - 3})
		table.insert(self.vision, {x = x, y = y - 2})
		table.insert(self.vision, {x = x, y = y - 1})
		table.insert(self.vision, {x = x + 1, y = y - 2})
		table.insert(self.vision, {x = x + 1, y = y - 1})
		table.insert(self.vision, {x = x - 1, y = y - 2})
		table.insert(self.vision, {x = x - 1, y = y - 1})
	elseif self.direction == 1 then
		table.insert(self.vision, {x = x + 3, y = y})
		table.insert(self.vision, {x = x + 2, y = y})
		table.insert(self.vision, {x = x + 1, y = y})
		table.insert(self.vision, {x = x + 1, y = y - 1})
		table.insert(self.vision, {x = x + 1, y = y + 1})
		table.insert(self.vision, {x = x + 2, y = y + 1})
		table.insert(self.vision, {x = x + 2, y = y - 1})
	elseif self.direction == 2 then
		table.insert(self.vision, {x = x, y = y + 3})
		table.insert(self.vision, {x = x, y = y + 2})
		table.insert(self.vision, {x = x, y = y + 1})
		table.insert(self.vision, {x = x + 1, y = y + 2})
		table.insert(self.vision, {x = x + 1, y = y + 1})
		table.insert(self.vision, {x = x - 1, y = y + 2})
		table.insert(self.vision, {x = x - 1, y = y + 1})
	elseif self.direction == 3 then
		table.insert(self.vision, {x = x - 3, y = y})
		table.insert(self.vision, {x = x - 2, y = y})
		table.insert(self.vision, {x = x - 1, y = y})
		table.insert(self.vision, {x = x - 1, y = y - 1})
		table.insert(self.vision, {x = x - 1, y = y + 1})
		table.insert(self.vision, {x = x - 2, y = y + 1})
		table.insert(self.vision, {x = x - 2, y = y - 1})
	end
	
	for k=1, #self.vision do
		if self.vision[k].x == map.player:getGridX() and self.vision[k].y == map.player:getGridY() then
			map:gameOver()
		end
	end
end

-- On dessine un carré rouge pour représenter les soldats.
function Soldier:draw()
	-- On stocke les valeurs actuelles des couleurs
	local r, g, b, a = love.graphics.getColor()
	love.graphics.setColor(255, 0, 0)
	love.graphics.rectangle("fill", self.x, self.y + hud_height, map.tile_size, map.tile_size)
	love.graphics.setColor(255, 0, 0, 100)
	for k=1, #self.vision do
		love.graphics.rectangle("fill", self.vision[k].x * map.tile_size, self.vision[k].y * map.tile_size + hud_height, map.tile_size, map.tile_size)
	end
	-- On rétablit les valeurs des couleurs
	love.graphics.setColor(r, g, b, a)
end

-- Retourne la classe Soldier
return Soldier
