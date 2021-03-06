local class         = require 'utils/middleclass'
local MovableEntity = require 'entities/movableentity'

-- Classe `Player`
local Player = class('Player', MovableEntity)

-- Méthode d'initialisation de la classe `Player`, utilisée pour modéliser le joueur.
function Player:initialize(x, y)
	MovableEntity.initialize(self)
	self.x      = x
	self.y      = y
	self.dest_x = x
	self.dest_y = y
	self.speed  = 10
end

-- Surcharge de la méthode `Entity:setX`
function Player:setX(new_x)
	self.x      = new_x
	self.dest_x = new_x
end

-- Surcharge de la méthode `Entity:setY`
function Player:setY(new_y)
	self.y      = new_y
	self.dest_y = new_y
end

-- Met à jour le joueur
-- Fait bouger le joueur et déclenche son attaque si la touche barre espace est activée.
function Player:update(dt)
	MovableEntity.update(self, dt)
	self:move(dt)
	if love.keyboard.isDown(" ") then
		self:stab()
	end
end

-- Vérifie si le joueur peut se déplacer dans la direction voulue.
-- Ne fonctionne pas.
function Player:canMove()
	local x = self:getGridX()
	local y = self:getGridY()

	print("player can move")

	if self.direction == 0 then
		y = y - 1
	elseif self.direction == 1 then
		x = x + 1
	elseif self.direction == 2 then
		y = y + 1
	elseif self.direction == 3 then
		x = x - 1
	end
	-- print(y)
	-- print(x)

	local entity = map:getEntityOn(x, y)

	-- print(entity)

	-- Si le joueur ne peut pas bouger, on le rend immobile en
	-- assignant à ses coordonnées de destination ses coordonnées actuelles.
	if entity and entity.is_blocking then
		-- print("player can't move")
		self.dest_x = self.x
		self.dest_y = self.y
	end
end

-- Black magic involved.
-- Do not edit.
-- Fonction permettant de faire bouger le joueur.
function Player:move(dt)
	-- On détecte les touches pressées et on agit en conséquence
	-- Si le joueur est en mouvement, on ne change pas son mouvement
	if     love.keyboard.isDown("down")  and self.is_moving == false then
		self:moveDown()
	elseif love.keyboard.isDown("up")    and self.is_moving == false then
		self:moveUp() 
	elseif love.keyboard.isDown("left")  and self.is_moving == false then
		self:moveLeft()
	elseif love.keyboard.isDown("right") and self.is_moving == false then
		self:moveRight()
	end

	-- On vérifie si le joueur peut bouger.
	self:canMove()
	
	-- Déplace petit à petit le joueur de `{x, y}` vers `dest_{x, y}`
	self.x = self.x - ((self.x - self.dest_x) * self.speed * dt)
	self.y = self.y - ((self.y - self.dest_y) * self.speed * dt)

	-- On arrondi les valeurs de self.x et self.y
	-- Pour être sûr que le joueur atteigne la case suivante.
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
	
	-- Si le joueur arrive à destination, le joueur n'est plus en mouvement
	if self.x == self.dest_x and self.y == self.dest_y then
		self.is_moving = false
	end

	-- print("Player.x :      " .. self.x)
	-- print("Player.dest_x : " .. self.dest_x)
	-- print("Player.grid_x : " .. self:getGridX())
	-- print("Player.y :      " .. self.y)
	-- print("Player.dest_y : " .. self.dest_y)
	-- print("Player.grid_y : " .. self:getGridY())
end

-- On tourne le joueur dans la direction voulue, on vérifie que la case sur
-- laquelle il veut se rendre existe et on le défini comme étant en mouvement
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

-- Attaque du joueur, permet d'éliminer l'entité se tenant devant lui
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

	-- Récupère l'entité se tenant devant lui
	local entity = map:getEntityOn(x, y)

	-- Si elle existe, on l'élimine
	if entity then
		entity:kill()
	end
end

-- Dessine l'instance du joueur
function Player:draw()
	-- On récupère les couleurs déjà définies
	local r, g, b, a = love.graphics.getColor()
	-- On défini la couleur à blanc
	love.graphics.setColor(255, 255, 255)
	-- On dessine le joueur
	love.graphics.rectangle("fill", self.x, self.y + hud_height, map.tile_size, map.tile_size)
	-- Begin debug
	-- Dessine un carré bleu représentant la direction du joueur et la case qu'il peut attaquer
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
	-- On remet les couleurs comme elles étaient
	love.graphics.setColor(r, g, b, a)
end

-- Retourne la classe Player
return Player
