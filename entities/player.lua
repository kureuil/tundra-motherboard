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
function Player:initialize(x, y)
	MovableEntity.initialize(self)
	self.x         = x
	self.y         = y
	self.dest_x    = x
	self.dest_y    = y
	self.speed     = 13
end

function Player:setX(new_x)
	self.x = new_x
	self.dest_x = new_x
end

function Player:setY(new_y)
	self.y = new_y
	self.dest_y = new_y
end

-- Met à jour le joueur
function Player:update(dt)
	MovableEntity.update(self, dt)
	-- print("Updating player")
	self:move(dt)
	if love.keyboard.isDown(" ") then
		self:stab()
	end
end

-- Black magic involved.
-- Do not edit.
function Player:move(dt)
	if love.keyboard.isDown("down") and self.is_moving == false then
		-- print("Zboub Down")
		self:moveDown()
	elseif love.keyboard.isDown("up") and self.is_moving == false then
		-- print("Zboub Up")
		self:moveUp()
	elseif love.keyboard.isDown("left") and self.is_moving == false then
		-- print("Zboub Left")
		self:moveLeft()
	elseif love.keyboard.isDown("right") and self.is_moving == false then
		-- print("Zboub Right")
		self:moveRight()
	end

	-- Déplace petit à petit le joueur de `{x, y}` vers `dest_{x, y}`
	self.x = self.x - ((self.x - self.dest_x) * self.speed * dt)
	self.y = self.y - ((self.y - self.dest_y) * self.speed * dt)

	if math.floor(self.x) == self.dest_x then
		self.x = math.floor(self.x)
	elseif math.ceil(self.x) == self.dest_x then
		self.x = math.ceil(self.x)
	end
	
	if math.floor(self.y) == self.dest_y then
		self.y = math.floor(self.y)
	elseif math.ceil(self.y) == self.dest_y then
		self.y = math.ceil(self.y)
	end
	
	if self.x == self.dest_x and self.y == self.dest_y then
		-- print("Zboub")
		self.is_moving = false
	end

	print("Player.x :      " .. self.x)
	print("Player.dest_x : " .. self.dest_x)
	print("Player.grid_x : " .. self:getGridX())
	print("Player.y :      " .. self.y)
	print("Player.dest_y : " .. self.dest_y)
	print("Player.grid_y : " .. self:getGridY())
end

function Player:moveDown()
	local new_y = self.dest_y + map.tile_size
	self.direction = 2
	if new_y < (480) then
		self.dest_y    = new_y
		self.is_moving = true
	end
end
function Player:moveUp()
	local new_y = self.dest_y - map.tile_size
	self.direction = 0
	if new_y >= (0) then
		self.dest_y    = new_y
		self.is_moving = true
	end
end

function Player:moveLeft()
	local new_x = self.dest_x - map.tile_size
	self.direction = 3
	if new_x >= 0 then
		self.dest_x    = new_x
		self.is_moving = true
	end
end

function Player:moveRight()
	local new_x = self.dest_x + map.tile_size
	self.direction = 1
	if new_x < 720 then
		self.dest_x    = new_x
		self.is_moving = true
	end
end

-- NINJAAAAAA
function Player:stab()
	local x = self:getGridX()
	local y = self:getGridY()

	if self.direction == 0 then
		y = y - 1
	elseif self.direction == 1 then
		x = x + 1
	elseif self.direction == 2 then
		y = y + 1
	elseif self.direction == 3 then
		x = x - 1
	end

	local entity = map:getEntityOn(x, y)

	if entity then
		entity:kill()
	end
end

-- Dessine l'instance du joueur
function Player:draw()
	local r, g, b, a = love.graphics.getColor()
	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle("fill", self.x, self.y + hud_height, map.tile_size, map.tile_size)
	-- Begin debug
	love.graphics.setColor(0, 0, 255)
	if self.direction == 0 then
		love.graphics.rectangle("fill", self.x, self.y + hud_height - map.tile_size, map.tile_size, map.tile_size)
	elseif self.direction == 1 then
		love.graphics.rectangle("fill", self.x + map.tile_size, self.y + hud_height, map.tile_size, map.tile_size)
	elseif self.direction == 2 then
		love.graphics.rectangle("fill", self.x, self.y + hud_height + map.tile_size, map.tile_size, map.tile_size)
	elseif self.direction == 3 then
		love.graphics.rectangle("fill", self.x - map.tile_size, self.y + hud_height, map.tile_size, map.tile_size)
	end
	-- End debug
	love.graphics.setColor(r, g, b, a)
end

return Player