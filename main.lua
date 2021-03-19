function love.load()
    ind = 0
    qqq = 0
    require("Foundation/GameInitializer")

    sceneManager = SceneManager()
    soundManager = SoundManager()

    scene1 = PictureScene("resources/fire.png", backGroundSource1)
    scene2 = PictureScene("resources/water.png", backGroundSource2)

    scene1:SetNextScene(scene2)
    scene2:SetNextScene(scene1)

    sceneManager:LoadScene(scene1)

    input = Input()
    input:bind("space", "space")

    --love.audio.setPosition(300, 300)

    --backGroundSource1:play()
    -- soundManager.musicChannel:Play(backGroundSource1:clone(), true, true, 1)



    -- local cartographer = require 'cartographer'

    -- -- load a map
    map = cartographer.load("resources/Spritesheet/tilemap.lua")
    -- -- get a layer by name
    -- local terrain = map.layers.terrain
    -- -- get a tile at a position
    -- local gid = terrain:getTileAtGridPosition(32, 32)
    -- -- check a tile property
    -- local solid = map:getTileProperty(gid, 'solid')

    -- function love.update(dt)
    --     -- update animations
    --     map:update(dt)
    -- end

    -- function love.draw()
    --     -- draw the whole map
    --     map:draw()
    --     -- draw an individual layer
    --     map.layers.terrain:draw()
    -- end

end

function love.update(dt)
    if input:pressed("space") then
        sceneManager:LoadScene(sceneManager.currentScene.nextScene)
        --local mx, my = love.mouse.getPosition()
    end
    soundManager:update(dt)
    sceneManager:update(dt)
end

function love.draw()
    map.layers["Слой тайлов 2"]:draw()

    sceneManager:draw()
    love.graphics.print(""..qqq)
    -- love.graphics.print(#soundManager.musicChannel.soundSources)
end

function love.mousepressed(...)
    sceneManager:mousepressed(...)
end

function love.keypressed(key)
    sceneManager:keypressed(key)
end

function love.textinput(key)
    sceneManager:textinput(key)
end

function love.mousereleased(...)
	sceneManager:mousereleased(...)
end

-- function love.load()
--     map = LoadTiledMap("resources/Spritesheet")
-- end

-- function love.update(dt)

-- end

-- function love.draw()
--     map:draw()
-- end

-- function LoadTiledMap(path)
--     local _map = require(path.."/tilemap")

--     _map.quads = {}

--     local tileset = _map.tilesets[1]

--     _map.tileset = tileset
--     _map.image = love.graphics.newImage(path.."/"..tileset.image)

--     for y = 0, (tileset.imageheight / tileset.tileheight) - 1 do
--         for x = 0, (tileset.imagewidth / tileset.tilewidth) - 1 do
--             local quad = love.graphics.newQuad(
--                 x * tileset.tilewidth,
--                 y * tileset.tileheight,
--                 tileset.tilewidth,
--                 tileset.tileheight,
--                 tileset.imagewidth,
--                 tileset.imageheight
--             )

--             table.insert(_map.quads, quad)
--         end
--     end

--     function _map:draw()
--         for i, layer in ipairs(self.layers) do
--             for y = 0, layer.height - 1 do
--                 for x = 0, layer.width - 1 do
--                     local index = (x + y * layer.width) + 1
--                     local tid = layer.data[index]

--                     if tid ~= 0 then
--                         local quad = self.quads[tid]

--                         local xx = x * self.tileset.tilewidth
--                         local yy = y * self.tileset.tileheight

--                         love.graphics.draw(self.image, quad, xx, yy)
--                     end
--                 end
--             end
--         end
--     end

--     return _map
-- end
