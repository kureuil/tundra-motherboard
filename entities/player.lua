local class         = require '../utils/middleclass'
local MovableEntity = require 'entity/movableentity'

-- Classe `Player`
local Player = class('Player', MovableEntity)

-- Méthode d'initialisation de la classe `Player`
-- Défini les variables:
-- * act_x: position actuelle du joueur sur l'axe des abscisses (en tuiles)
-- * act_y: position actuelle du joueur sur l'axe des ordonnées (en tuiles)
-- * grid_x: destination du joueur sur l'axe des abscisses (en tuiles)
-- * grid_x: destination du joueur sur l'axe des ordonnées (en tuiles)
-- * is_moving: permet de savoir si le joueur est en déplacement
-- * speed: Vitesse du joueur
function Player:initialize(x, y, speed)
	MovableEntity.initialize(self)
	self.x = x
	self.y = y
	self.speed = speed
end

-- Met à jour le joueur
function Player:update(dt)
	MovableEntity.update(self, dt)
	if false then
		self:move()
		print(self.act_x)
		print(self.grid_x)
		print(self.act_y)
		print(self.grid_y)
	end

	-- Déplace petit à petit le joueur de `act_{x, y}` vers `grid_{x, y}`
	-- self.act_x = self.act_x - ((self.act_x - self.grid_x) * self.speed * dt)
	-- self.act_y = self.act_y - ((self.act_y - self.grid_y) * self.speed * dt)


end

function Player:move()

end

-- Dessine l'instance du joueur
function Player:draw()
	love.graphics.rectangle("fill", self.x, self.y + hud_height, map.tile_size, map.tile_size)
end

return Player