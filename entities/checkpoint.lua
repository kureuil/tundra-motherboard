local class      = require 'utils/middleclass'
local TileEntity = require 'entities/tileentity'

local Checkpoint = class('Checkpoint', TileEntity)
-- Fonction d'initialisation de la class `Checkpoint`, utilisée pour passer au tableau
-- suivant dès que le joueur pose le pied dessus
function Checkpoint:initialize()
	TileEntity.initialize(self)
	self.is_blocking = false
end

-- Vérifie si le joueur est sur la même case que le checkpoint. Si c'est le cas, on passe à
-- l'écran suivant.
function Checkpoint:update(dt)
	if map.player:getGridX() == self:getGridX() and map.player:getGridY() == self:getGridY() then
		map:nextScreen()
	end
end

-- Dessine un carré rouge non opaque pour signaliser le checkpoint.
function Checkpoint:draw()
	local r, g, b, a = love.graphics.getColor()
	love.graphics.setColor(100, 0, 0, 100)
	love.graphics.rectangle("fill", self.x, self.y + hud_height, map.tile_size, map.tile_size)
	love.graphics.setColor(r, g, b, a)
end

-- Retourne la class Checkpoint
return Checkpoint