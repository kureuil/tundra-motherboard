local class             = require 'utils/middleclass'
local Entity            = require 'entities/entity'
local TileEntity        = require 'entities/tileentity'
local Player            = require 'entities/player'
local Soldier           = require 'entities/soldier'
local EntityDictionnary = require 'maps/entitydictionnary'

local Map = class 'Map'
function Map:initialize(screens)
	self.screens           = screens
	self.current_screen_id = 1
	self.current_screen    = self.screens[self.current_screen_id]
	self.tiles             = nil
	self.tile_size         = self.current_screen.tile_size
	self.entities          = {}
	self.player            = {}
	self.base_path         = nil
	self:loadScreen(self.current_screen)
end

-- Fait apparaître un entité sur la map et l'ajoute au
-- registre des entités à gérer.
function Map:spawnEntity(entity, x, y)
	print(entity)
	print(x)
	print(y)
	if entity:isInstanceOf(Entity) or entity:isSubclassOf(Entity) then
		print("spawn process started")
		entity:setX(x * self.tile_size)
		entity:setY(y * self.tile_size)
		entity.spawned = true
		if entity:isInstanceOf(Player) then
			self.player = entity
		else
			table.insert(self.entities, entity)
		end
	end
end

function Map:loadScreen()
	self:loadEntities()
	self:loadTiles(self.current_screen.tiles)
	self.tiles = self.current_screen.tiles
	self:spawnEntity(
		Player:new(),
		self.current_screen.player.x,
		self.current_screen.player.y
	)
end

function Map:loadEntities()
	self.entities = {}
	local clients = self.current_screen.entities
	for k=1, #clients.soldiers do
		self:spawnEntity(Soldier:new(), clients.soldiers[k].x, clients.soldiers[k].y)
	end
end

function Map:loadTiles(tiles)
	for x=1, #tiles do
		for y=1, #tiles[x] do
			print(tiles[x][y])
			local tile_content = tiles[x][y]
			if EntityDictionnary[tile_content] then
				self:spawnEntity(EntityDictionnary[tile_content], x, y)
			end
		end
	end
end

function Map:nextScreen()
	if (self.current_screen_id + 1) <= #self.screens then
		self.current_screen_id = self.current_screen_id + 1
		self:loadScreen(self.current_screen_id)
	else
		self:endingScreen()
	end
end

function Map:endingScreen()
	
end

-- Retourne une table contenant à l'index 0 la largeur de
-- la map et à l'index 1 sa hauteur.
function Map:getSize()
	return {#self.tiles[1], #self.tiles}
end

-- Retourne une matrice contenant toutes les tuiles de l'écran actuel
function Map:getTiles()
	return self.screens[self.current_screen]
end

function Map:getTile(x, y)
	return self.map[y][x]
end

function Map:getEntityOn(x, y)
	local size = self:getSize()
	
	if x < 0 or x > size[1] or y < 0 or y > size[2] then
		return false
	end
	print('#self.entities : ' .. #self.entities)
	if #self.entities == 0 then
		return false
	end
	for k=1, #self.entities do
		print(self.entities[k])
		if self.entities[k] ~= nil and self.entities[k]:getGridX() == x and self.entities[k]:getGridY() == y then
			return self.entities[k]
		end
		return false
	end
end

function Map:update(dt)
	for k=1, #self.entities do
		if self.entities[k] ~= nil then
			local entity = self.entities[k]
			entity:update(dt)
			if entity.spawned == false then
				self.entities[k] = nil
			end
		end
	end
	self.player:update(dt)
end

function Map:draw()
	for y=1, #self.tiles do
		for x=1, #self.tiles[y] do
			if self.tiles[y][x] == 1 then
				love.graphics.rectangle(
					"line",
					(x - 1) * self.tile_size,
					(y - 1) * self.tile_size + hud_height,
					self.tile_size,
					self.tile_size
				)
			end
		end
	end
	print(#self.entities)
	for k=1, #self.entities do
		print(self.entities[k])
		if self.entities[k] ~= nil then
			self.entities[k]:draw()
		end
	end
	self.player:draw()
end

return Map