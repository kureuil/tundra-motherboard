local class = require 'utils/middleclass'

-- Classe `Player`
Player = class("Player")
function Player:initialize(x, y, speed)
	self.act_x = x
	self.act_y = y
	self.grid_x = x
	self.grid_y = y
	self.speed = speed
end

-- Chargement des ressources (maps, sprites, sons, réglages, etc)
function love.load()
	-- Tile size: 48px
	-- Map height: 48 * 10 = 480px
	-- Map width: 48 * 15 = 720px
	map = {
		{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
		{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
		{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
		{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
		{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
		{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
		{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
		{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
		{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
		{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
	}
	hud_height = 96
	tile_size = 48
	player = Player:new(tile_size * 3, tile_size * 5, 10)
end

-- Mise  à jour des composantes
function love.update(dt)
	player.act_x = player.act_x - ((player.act_x - player.grid_x) * player.speed * dt)
	player.act_y = player.act_y - ((player.act_y - player.grid_y) * player.speed * dt)
end

-- Détection de pression des touches
function love.keypressed(key)
	if key == "down" then
		local new_y = player.grid_y + tile_size
		if new_y < (480 + hud_height) then
			player.grid_y = new_y
		end
	elseif key == "up" then
		local new_y = player.grid_y - tile_size
		if new_y >= (0 + hud_height) then
			player.grid_y = new_y
		end
	elseif key == "left" then
		local new_x = player.grid_x - tile_size
		if new_x >= 0 then
			player.grid_x = new_x
		end
	elseif key == "right" then
		local new_x = player.grid_x + tile_size
		if new_x < 720 then
			player.grid_x = new_x
		end
	end
end

-- Affichage des composantes
function love.draw()
	for y=1, #map do
		for x=1, #map[y] do
			if map[y][x] == 1 then
				love.graphics.rectangle("line", (x - 1) * tile_size, (y - 1) * tile_size + hud_height, tile_size, tile_size)
			end
		end
	end
    love.graphics.rectangle("fill", player.act_x, player.act_y, tile_size, tile_size)
end