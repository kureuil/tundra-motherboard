local class         = require 'utils/middleclass'
local MovableEntity = require 'entities/movableentity'

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
	self.grid_x = x
	self.grid_y = y
	self.speed = 10
end

function Player:setX(new_x)
	self.x = new_x
	self.grid_x = new_x
end

function Player:setY(new_y)
	self.y = new_y
	self.grid_y = new_y
end

-- Met à jour le joueur
function Player:update(dt)
	MovableEntity.update(self, dt)
	print("Updating player")

	if love.keyboard.isDown("down") then
		local new_y = self.grid_y + map.tile_size
		if new_y < (480) then
			self.grid_y = new_y
		end
	elseif love.keyboard.isDown("up") then
		local new_y = self.grid_y - map.tile_size
		if new_y >= (0) then
			self.grid_y = new_y
		end
	elseif love.keyboard.isDown("left") then
		local new_x = self.grid_x - map.tile_size
		if new_x >= 0 then
			self.grid_x = new_x
		end
	elseif love.keyboard.isDown("right") then
		local new_x = self.grid_x + map.tile_size
		if new_x < 720 then
			self.grid_x = new_x
		end
	end

	-- Déplace petit à petit le joueur de `act_{x, y}` vers `grid_{x, y}`
	self.x = self.x - ((self.x - self.grid_x) * self.speed * dt)
	self.y = self.y - ((self.y - self.grid_y) * self.speed * dt)

end

function Player:move()

end

-- Dessine l'instance du joueur
function Player:draw()
	love.graphics.rectangle("fill", self.x, self.y + hud_height, map.tile_size, map.tile_size)
end

return Player