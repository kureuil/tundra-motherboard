local class  = require 'utils/middleclass'
local Entity = require 'entities/entity'

local TileEntity = class('TileEntity', Entity)
-- Méthode d'initialisation de la classe `Player`
-- Défini les variables:
-- * texture_path: nom du fichier de l'image
-- * texture: objet image de la texture
-- * is_blocking: permet de savoir si l'entité bloque les mouvements du joueur
function TileEntity:initialize(texture_path)
	Entity.initialize(self)
	if texture_path ~= nil then
		self.texture_path = texture_path
		-- On charge le fichier image
		self.texture = love.graphics.newImage(map.base_path..'gfx'..texture_path..'.jpg')
	end
end

-- Fonction draw = fonction affichage des textures de l'entité
function TileEntity:draw()
	love.graphics.draw(self.texture, x, y + hud_height)
end

return TileEntity