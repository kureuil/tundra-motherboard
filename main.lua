-- On inclut la classe `Player`
local Player    = require 'entities/player'
local MapLoader = require 'maps/maploader'
-- Chargement des ressources (maps, sprites, sons, réglages, etc)
function love.load()
	-- Taille d'un tuile: 48px
	-- Hauteur: 48 * 10 = 480px
	-- Largeur: 48 * 15 = 720px
	-- On initialise le chargeur de map
	maploader = MapLoader:new()
	-- On charge la map `map1`
	map = maploader:load('map1')
	-- On défini la hauteur de l'UI située au dessus de la zone de dessin 
	hud_height = 96
	-- player = Player:new(tile_size * 3, tile_size * 5, 10)
end

-- À chaque frame on met à jour la map
function love.update(dt)
	map:update(dt)
end

-- Puis on la dessine
function love.draw()
	map:draw()
end