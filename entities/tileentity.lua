local class  = require 'utils/middleclass'
local Entity = require 'entities/entity'

local TileEntity = class('TileEntity', Entity)
-- Méthode d'initialisation de la classe `TileEntity`, utilisée pour modéliser les entités
-- fixes disposées sur une tuile du tableau.
-- Défini les variables:
-- * texture_path: nom du fichier de l'image
-- * texture: objet image de la texture
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

-- Retourne la classe TileEntity
return TileEntity