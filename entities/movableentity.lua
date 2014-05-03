local class  = require 'utils/middleclass'
local Entity = require 'entities/entity'

local MovableEntity = class('MovableEntity', Entity)
-- Méthode d'initialisation de la classe `Player`
-- Défini les variables:
-- * dest_x: position actuelle du joueur sur l'axe des abscisses (en tuiles)
-- * dest_y: position actuelle du joueur sur l'axe des ordonnées (en tuiles)
-- * is_moving: permet de savoir si le joueur est en déplacement
-- * speed: Vitesse du joueur
-- * direction : Direction que regarde le joueur ([0 => haut, 1 => droite, 2 => bas, 3 => gauche]) 
function MovableEntity:initialize()
	Entity.initialize(self)
	self.dest_x    = 0
	self.dest_y    = 0
	self.is_moving = false
	self.speed     = 10
	self.direction = 0
end

function MovableEntity:moveTo(shift_x, shift_y)
	if self:canMoveTo(self.grid_x + shift_x, self.grid_y + shift_y) then
		self.dest_x = self.grid_x + shift_x
		self.dest_y = self.grid_y + shift_y
	end
end

function MovableEntity:canMoveTo(x, y)
	local canMove = true
	
	if x < 0 or y < 0 or x > #map.tiles[1] or y > #map.tiles then
		canMove = false
	end
	
	if map.getTile(x, y) then
		canMove = false
	end
	
	return canMove
end

function MovableEntity:update(dt)

end

return MovableEntity