local TileEntity = require 'entities/entity'
local Checkpoint = require 'entities/checkpoint'
-- Retourne le "Dictionnaire des entités". Fait correspondre une clé (généralement un nombre) avec une entité.
return {
	[1] = TileEntity:new(),
	['next'] = Checkpoint:new()
}