local class             = require 'utils/middleclass'
local Entity            = require 'entities/entity'
local TileEntity        = require 'entities/tileentity'
local Player            = require 'entities/player'
local Soldier           = require 'entities/soldier'
local EntityDictionnary = require 'maps/entitydictionnary'

local Map = class 'Map'
-- Fonction d'initialisation de la map. Créé les variables :
-- * screens: liste des tableaux de la map
-- * current_screen_id: ID du tableau actuel
-- * current_screen: objet du tableau actuel
-- * tiles: matrice contenant les tuiles du tableau
-- * tile_size: taille (en pixels) des tuiles
-- * entities: tableau contenant toutes les entités chargées (sauf le joueur)
-- * player: instace du joueur actuel
-- * base_path: localisation (sur le disque dur) de la map. Utilisé pour charger les ressources.
-- * background: image utilisée en fond
function Map:initialize(screens)
	self.screens               = screens
	self.current_screen_id     = 1
	self.current_screen        = self.screens[self.current_screen_id]
	self.tiles                 = nil
	self.tile_size             = self.current_screen.tile_size
	self.entities              = {}
	self.player                = {}
	self.base_path             = nil
	self.background            = nil
	self.state                 = 'game'
	self.current_screen_height = 0
	self.current_screen_width  = 0
	-- Charge le premier tableau
	self:loadScreen(self.current_screen)
end

-- Fait apparaître un entité sur la map et l'ajoute au
-- registre des entités à gérer.
function Map:spawnEntity(entity, x, y)
	if entity:isInstanceOf(Entity) or entity:isSubclassOf(Entity) then
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

-- Fonction chargeant le tableau actuel de la map.
-- Charge les entités, puis les tuiles et enfin le background.
-- Fait ensuite apparaître le joueur.
function Map:loadScreen()
	self.state = 'game'
	self:loadEntities()
	self:loadTiles(self.current_screen.tiles)
	self.tiles = self.current_screen.tiles
	self.current_screen_height = self:getSize()[2] * self.tile_size
	self.current_screen_width = self:getSize()[1] * self.tile_size
	self.background = love.graphics.newImage( "maps/levels/gfx/screen_"..self.current_screen_id..".jpg" )
	self:spawnEntity(
		Player:new(),
		self.current_screen.player.x,
		self.current_screen.player.y
	)
end

-- Fonction chargeant les entités du tableau actuel.
-- Commence par vider le registre, puis parcourt la liste des entités fournie
-- par la map.
function Map:loadEntities()
	self.entities = {}
	local clients = self.current_screen.entities
	if clients.soldiers ~= nil then
		for k=1, #clients.soldiers do
			self:spawnEntity(Soldier:new(), clients.soldiers[k].x, clients.soldiers[k].y)
		end
	end
end

-- Fonction chargeant les tuiles de la map.
-- Parcourt la matrice fournie par la map, parcourt d'abord dans l'axe des ordonnées puis
-- dans l'axe des abscisses.
-- Instancie ensuite le contenu de la tuile en utilisant le registre global des entités.
function Map:loadTiles(tiles)
	for y=1, #tiles do
		for x=1, #tiles[y] do
			local tile_content = tiles[y][x]
			if EntityDictionnary[tile_content] then
				self:spawnEntity(EntityDictionnary[tile_content], x - 1, y - 1)
			end
		end
	end
end

-- Fonction chargeant le tableau suivant.
-- Si le tableau suivant n'existe pas, afficher les crédits (non implémenté).
function Map:nextScreen()
	if (self.current_screen_id + 1) <= #self.screens then
		self.current_screen_id = self.current_screen_id + 1
		self.current_screen = self.screens[self.current_screen_id]
		self:loadScreen()
	else
		self:endingScreen()
	end
end

-- Fonction affichant les crédits
function Map:endingScreen()
	self.state = 'ending-screen'
end

function Map:gameOver()
	self.state = 'game-over'
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

-- Fonction retournant le contenu de la tuile aux coordonnées (x, y)
function Map:getTile(x, y)
	return self.map[y][x]
end

-- Fonction retournant l'entité présente aux coordonnées (x, y)
-- Commence par vérifier que nles coordonnées sont valides et que des entités sont présentes.
-- Parcourt ensuite le registre des entités chargées et retourne la première ayant des coordonnées
-- correspondantes.
function Map:getEntityOn(x, y)
	local size = self:getSize()
	
	if x < 0 or x > size[1] or y < 0 or y > size[2] then
		return false
	end

	-- print(#self.entities)

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

-- Fontion mettant à jour la map.
-- Parcourt le registre des entités chargées, met à jour ces dernières et supprime celles qui ne sont plus.
-- Met ensuite à jour le joueur.
function Map:update(dt)
	if self.state == 'game' then
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
	elseif self.state == 'game-over' or self.state == 'ending-screen' then
		if love.keyboard.isDown (' ', 'return') then
			if self.state == 'ending-screen' then
				self.current_screen_id = 1
				self.current_screen = self.screens[self.current_screen_id]
			end
				self:loadScreen()
		elseif love.keyboard.isDown('escape') then
			love.event.quit()
		end
	end
end

-- Dessine la map et son background.
-- Appelle la fonction `draw` de chaque entité chargée, puis la fonction `draw` du joueur.
function Map:draw()
	local r, g, b, a = love.graphics.getColor()
	local font_buffer = love.graphics.getFont()
	love.graphics.draw( self.background, 0, hud_height )
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
		if self.entities[k] ~= nil then
			self.entities[k]:draw()
		end
	end
	self.player:draw()
	if self.state == 'game-over' then
		love.graphics.setColor(0, 0, 0, 175)
		love.graphics.rectangle("fill", 0, 0 + hud_height, self.current_screen_width, self.current_screen_height)
		love.graphics.setFont(love.graphics.newFont(36))
		love.graphics.setColor(255, 255, 255)
		love.graphics.print('GAME OVER', 250, 180)
		love.graphics.setFont(love.graphics.newFont(18))
		love.graphics.print('Appuyez sur espace ou entrée pour réessayer', 140, 400)
		love.graphics.print('Appuyez sur Echap pour quitter', 300, 427)
	elseif self.state == 'ending-screen' then
		love.graphics.setColor(0, 0, 0, 175)
		love.graphics.rectangle("fill", 0, 0 + hud_height, self.current_screen_width, self.current_screen_height)
		love.graphics.setFont(love.graphics.newFont(36))
		love.graphics.setColor(255, 255, 255)
		love.graphics.print('Vous avez gagné !', 200, 180)
		love.graphics.setFont(love.graphics.newFont(18))
		love.graphics.print('Merci d\'avoir joué', 284, 373)
		love.graphics.print('Appuyez sur espace ou entrée pour recommencer', 140, 400)
		love.graphics.print('Appuyez sur Echap pour quitter', 244, 427)
	end
	love.graphics.setFont(font_buffer)
	love.graphics.setColor(r, g, b, a)
end

-- Retourne la classe Map
return Map
