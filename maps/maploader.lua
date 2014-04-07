local class  = require 'utils/middleclass'
local Map    = require 'maps/map'
local Player = require 'entities/player'

local MapLoader = class 'MapLoader'
function MapLoader:initialize()
	self.path = 'maps/levels/'
end

function MapLoader:load(level)
	print(self.path) -- debug & all
	-- On charge la map ayant un nom corespondant
	local map = require(self.path..level)
	-- On créé une nouvelle instance de Map
	-- en spécifiant les tuiles et la taille des tuiles (ici carrés de 48px)
	local instance = Map:new(map)
	return instance
end

return MapLoader