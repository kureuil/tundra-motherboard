local class = require 'utils/middleclass'

local Entity = class 'Entity'
-- Méthode d'initialisation de la classe `Player`
-- Défini les variables:
-- * grid_x: destination du joueur sur l'axe des abscisses (en tuiles)
-- * grid_x: destination du joueur sur l'axe des ordonnées (en tuiles)
function Entity:initialize()
	self.x       = 0
	self.y       = 0
	self.grid_x  = 0
	self.grid_y  = 0
	self.spawned = false
end

function Entity:setX(new_x)
	self.x = new_x
end

function Entity:setY(new_y)
	self.y = new_y
end

function Entity:update(dt)
end

function Entity:draw()
end

return Entity