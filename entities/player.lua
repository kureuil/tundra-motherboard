local class         = require 'utils/middleclass'
local MovableEntity = require 'entities/movableentity'

-- Classe `Player`
local Player = class('Player', MovableEntity)

-- Méthode d'initialisation de la classe `Player`
-- Défini les variables:
-- * act_x: position actuelle du joueur sur l'axe des abscisses (en pixels)
-- * act_y: position actuelle du joueur sur l'axe des ordonnées (en pixels)
-- * grid_x: destination du joueur sur l'axe des abscisses (en pixels)
-- * grid_x: destination du joueur sur l'axe des ordonnées (en pixels)
-- * is_moving: permet de savoir si le joueur est en déplacement
-- * speed: Vitesse du joueur
function Player:initialize(x, y)
	MovableEntity.initialize(self)
	self.x = x
	self.y = y
	self.grid_x = x
	self.grid_y = y
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
	self:move()
end

-- Black magic involved.
-- Do not edit.
function Player:move()
	if love.keyboard.isDown("down") then
		self:moveDown()
	elseif love.keyboard.isDown("up") then
		self:moveUp()
	elseif love.keyboard.isDown("left") then
		self:moveLeft()
	elseif love.keyboard.isDown("right") then
		self:moveRight()
	end

	-- Déplace petit à petit le joueur de `{x, y}` vers `grid_{x, y}`
	self.x = self.x - ((self.x - self.grid_x) * self.speed * dt)
	self.y = self.y - ((self.y - self.grid_y) * self.speed * dt)
end

function Player:moveDown()
	local new_y = self.grid_y + map.tile_size
	if new_y < (480) then
		self.grid_y = new_y
	end
end

function Player:moveUp()
	local new_y = self.grid_y - map.tile_size
	if new_y >= (0) then
		self.grid_y = new_y
	end
end

function Player:moveLeft()
	local new_x = self.grid_x - map.tile_size
	if new_x >= 0 then
		self.grid_x = new_x
	end
end

function Player:moveRight()
	local new_x = self.grid_x + map.tile_size
	if new_x < 720 then
		self.grid_x = new_x
	end
end

-- Dessine l'instance du joueur
function Player:draw()
	love.graphics.rectangle("fill", self.x, self.y + hud_height, map.tile_size, map.tile_size)
end

return Player