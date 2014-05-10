local class  = require 'utils/middleclass'
local Entity = require 'entities/entity'

local MovableEntity = class('MovableEntity', Entity)
-- Méthode d'initialisation de la classe `MovableEntity`, utilisée pour modéliser
-- les entités mobiles.
-- Défini les variables:
-- * dest_x: position de destination de l'entité sur l'axe des abscisses (en pixels)
-- * dest_y: position de destination de l'entité sur l'axe des ordonnées (en pixels)
-- * is_moving: permet de savoir si l'entité est en déplacement
-- * speed: Vitesse de l'entité
-- * direction : Direction dans laquelle regarde l'entité ([0 => haut, 1 => droite, 2 => bas, 3 => gauche]) 
function MovableEntity:initialize()
	Entity.initialize(self)
	self.dest_x    = 0
	self.dest_y    = 0
	self.is_moving = false
	self.speed     = 10
	self.direction = 0
end

-- Déplace l'entité relativement d'un certain nombre de case.
-- Calcul les coordnoonées de destination en pixels après avoir vérifié que
-- l'entité pouvait atteindre la case désirée.
function MovableEntity:moveTo(shift_x, shift_y)
	if self:canMoveTo(self.grid_x + shift_x, self.grid_y + shift_y) then
		self.dest_x = self.grid_x + shift_x
		self.dest_y = self.grid_y + shift_y
	end
end

-- Vérifie si l'entité peut se rendre aux coordonnées données
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

-- Retourne la class MovableEntity
return MovableEntity