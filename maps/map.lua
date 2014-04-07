local class      = require 'utils/middleclass'
local Entity     = require 'entities/entity'
local TileEntity = require 'entities/tileentity'
local Player     = require 'entities/player'

local Map = class 'Map'
function Map:initialize(screens)
	self.screens           = screens
	self.current_screen_id = 1
	self.current_screen    = self.screens[self.current_screen_id]
	self.tiles             = nil
	self.tile_size         = self.current_screen.tile_size
	self.entities          = {}
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
		table.insert(self.entities, entity)
	else
		return
	end
end

function Map:loadScreen()
	self:loadEntities()
	self:loadTiles(self.current_screen.tiles)
	self.tiles = self.current_screen.tiles
	self:spawnEntity(
		Player:new(self.current_screen.player.x, self.current_screen.player.y),
		self.current_screen.player.x,
		self.current_screen.player.y
	)
end

function Map:loadEntities()
	self.entities = {}
end

function Map:loadTiles(tiles)
	for x=1, #tiles do
		for y=1, #tiles[x] do
			print(tiles[x][y])
			local tile_content = tiles[x][y]
			if tile == 001 then
				self:spawnEntity(TileEntity, x, y)
			else
				
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

function Map:update(dt)
	for k=1, #self.entities do
		self.entities[k]:update(dt)
	end
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
	for k=1, #self.entities do
		self.entities[k]:draw()
	end
end

return Map