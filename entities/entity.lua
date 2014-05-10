local class = require 'utils/middleclass'

local Entity = class 'Entity'
-- Méthode d'initialisation de la classe `Entity'
-- Défini les variables:
-- * x: coordonnées (en pixels) de l'entité
-- * y: coordonnées (en pixels) de l'entité
-- * grid_x: coordonnées (en tuiles) de l'entité
-- * grid_y: coordonnées (en tuiles) de l'entité
-- * spawned: statut de l'entité, morte ou vivante.
-- * is_blocking: l'entité bloque elle les mouvements du joueur
function Entity:initialize()
	self.x           = 0
	self.y           = 0
	self.grid_x      = 0
	self.grid_y      = 0
	self.spawned     = false
	self.is_blocking = true
end

-- Fonction permettant de changer les coordonnées de l'entité
function Entity:setX(new_x)
	self.x = new_x
end

-- Fonction permettant de changer les coordonnées de l'entité
function Entity:setY(new_y)
	self.y = new_y
end

-- Fonction retournant les coordonnées de l'entité
function Entity:getGridX()
	return math.floor(self.x / map.tile_size)
end

-- Fonction retournant les coordonnées de l'entité
function Entity:getGridY()
	return math.floor(self.y / map.tile_size)
end

-- Fonction déclarant l'entité comme "à supprimer"
function Entity:kill()
	self.spawned = false
end

-- Fonction mettant à jour l'entité
function Entity:update(dt)
end

-- Fonction dessinant l'entité
function Entity:draw()
end

-- Retourne la classe Entity
return Entity
