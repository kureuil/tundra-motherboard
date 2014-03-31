local class = require '../utils/middleclass'
local Map   = require 'maps/map'

local MapLoader = class 'MapLoader'
function MapLoader:initialize()
	self.path = 'maps/levels/'
end

function MapLoader:load(level)
	print(self.path)
	local map = require(self.path..level)
	return Map:new(map.tiles, 48)
end

return MapLoader