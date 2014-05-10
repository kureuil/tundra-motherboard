local class  = require 'utils/middleclass'
local Map    = require 'maps/map'
local Player = require 'entities/player'

local MapLoader = class 'MapLoader'
-- Fonction d'initialisation de la class MapLoader.
-- Défini la variable path qui est le chemin ou le MapLoader ira chercher les maps.
function MapLoader:initialize()
	self.path = 'maps/levels/'
end

function MapLoader:load(level)
	print(self.path) -- debug & all
	-- On charge la map ayant un nom corespondant
	local map = require(self.path..level)
	map.base_path = self.path..level
	-- On créé une nouvelle instance de Map
	-- en spécifiant les tuiles et la taille des tuiles (ici carrés de 48px)
	local instance = Map:new(map)
	return instance
end

-- Retourne la classe MapLoader
return MapLoader