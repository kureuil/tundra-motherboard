local class = require '../utils/middleclass'

-- Classe `Player`
local Player = class("Player")

-- Méthode d'initialisation de la class `Player`
-- Défini les variables:
-- * act_x: position actuelle du joueur sur l'axe des abscisses (en pixels)
-- * act_y: position actuelle du joueur sur l'axe des ordonnées (en pixels)
-- * grid_x: destination du joueur sur l'axe des abscisses (en pixels)
-- * grid_x: destination du joueur sur l'axe des ordonnées (en pixels)
-- * speed: Vitesse du joueur
function Player:initialize(x, y, speed)
	self.act_x = x
	self.act_y = y
	self.grid_x = x
	self.grid_y = y
	self.speed = speed
end

-- Met à jour le joueur
function Player:update(dt)
	if love.keyboard.isDown("down") then
		local new_y = self.grid_y + tile_size
		if new_y < (480 + hud_height) then
			self.grid_y = new_y
		end
	elseif love.keyboard.isDown("up") then
		local new_y = self.grid_y - tile_size
		if new_y >= (0 + hud_height) then
			self.grid_y = new_y
		end
	elseif love.keyboard.isDown("left") then
		local new_x = self.grid_x - tile_size
		if new_x >= 0 then
			self.grid_x = new_x
		end
	elseif love.keyboard.isDown("right") then
		local new_x = self.grid_x + tile_size
		if new_x < 720 then
			self.grid_x = new_x
		end
	end

	-- Déplace petit à petit le joueur de `act_{x, y}` vers `grid_{x, y}`
	self.act_x = self.act_x - ((self.act_x - self.grid_x) * self.speed * dt)
	self.act_y = self.act_y - ((self.act_y - self.grid_y) * self.speed * dt)
end

-- Dessine l'instance du joueur
function Player:draw()
	love.graphics.rectangle("fill", self.act_x, self.act_y, tile_size, tile_size)
end

return Player