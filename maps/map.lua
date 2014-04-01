local class  = require 'utils/middleclass'
local Entity = require 'entities/entity'

local Map = class 'Map'
function Map:initialize(tiles, tile_size)
	self.tiles = tiles
	self.tile_size = tile_size
	self.entities = {}
end

-- Fait apparaître un entité sur la map et l'ajoute au
-- registre des entités à gérer.
function Map:spawnEntity(entity, x, y)
	if entity:isInstanceOf(Entity) or entity:isSubclassOf(Entity) then
		print("spawn process started")
		entity:setX(x * self.tile_size)
		entity:setY(y * self.tile_size)
		entity.spawned = true
		table.insert(self.entities, entity)
	else
		return
	end
end

-- Retourne une table contenant à l'index 0 la largeur de
-- la map et à l'index 1 sa hauteur.
function Map:getSize()
	return {#self.tiles[1], #self.tiles}
end

function Map:getTile(x, y)
	return self.map[y][x]
end

function Map:update(dt)
	for k=1, #self.entities do
		self.entities[k]:update(dt)
	end
end

function Map:draw()
	for y=1, #self.tiles do
		for x=1, #self.tiles[y] do
			if self.tiles[y][x] == 1 then
				love.graphics.rectangle("line", (x - 1) * self.tile_size, (y - 1) * self.tile_size + hud_height, self.tile_size, self.tile_size)
			end
		end
	end
	for k=1, #self.entities do
		self.entities[k]:draw()
	end
end

return Map