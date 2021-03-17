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
    sceneManager:draw()
    love.graphics.print(qqq)
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
