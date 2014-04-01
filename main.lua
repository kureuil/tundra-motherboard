-- On inclut la classe `Player`
local Player = require 'entities/player'
local MapLoader = require 'maps/maploader'
-- Chargement des ressources (maps, sprites, sons, réglages, etc)
function love.load()
	-- Taille d'un tuile: 48px
	-- Hauteur: 48 * 10 = 480px
	-- Largeur: 48 * 15 = 720px
	maploader = MapLoader:new()
	map = maploader:load('map1')
	
	hud_height = 96
	-- player = Player:new(tile_size * 3, tile_size * 5, 10)
end

-- Mise à jour des composantes
function love.update(dt)
	map:update(dt)
end

-- Affichage des composantes
function love.draw()
	map:draw()
    -- player:draw()
end