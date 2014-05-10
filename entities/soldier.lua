local class         = require 'utils/middleclass'
local MovableEntity = require 'entities/movableentity'

local Soldier = class('Soldier', MovableEntity)

-- Soldat, actuellement assimilé à une plante verte servant juste à décorée.
function Soldier:initialize()

end

function Soldier:update(dt)
	-- body
end

-- On dessine un carré rouge pour représenter les soldats.
function Soldier:draw()
	-- On stocke les valeurs actuelles des couleurs
	local r, g, b, a = love.graphics.getColor()
	love.graphics.setColor(255, 0, 0)
	love.graphics.rectangle("fill", self.x, self.y + hud_height, map.tile_size, map.tile_size)
	-- On rétablit les valeurs des couleurs
	love.graphics.setColor(r, g, b, a)
end

-- Retourne la classe Soldier
return Soldier