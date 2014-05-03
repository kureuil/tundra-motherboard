local TileEntity = require 'entities/entity'
local Checkpoint = require 'entities/checkpoint'

return {
	[1] = TileEntity:new(),
	['next'] = Checkpoint:new()
}