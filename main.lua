-- On inclut la classe `Player`
local Player = require 'entities/player'
-- Chargement des ressources (maps, sprites, sons, réglages, etc)
function love.load()
	-- Taille d'un tuile: 48px
	-- Hauteur: 48 * 10 = 480px
	-- Largeur: 48 * 15 = 720px
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

-- Mise à jour des composantes
function love.update(dt)
	player:update(dt)
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
    player:draw()
end