function love.load()
    ind = 0
    qqq = 0
    require("Foundation/GameInitializer")

    sceneManager = SceneManager()

    scene1 = PictureScene("resources/fire.png")
    scene2 = PictureScene("resources/water.png")

    scene1:SetNextScene(scene2)
    scene2:SetNextScene(scene1)

    sceneManager:LoadScene(scene1)

    input = Input()
    input:bind("space", "space")
end

function love.update(dt)
    if input:pressed("space") then
        sceneManager:LoadScene(sceneManager.currentScene.nextScene)
        --local mx, my = love.mouse.getPosition()
    end
    sceneManager:update(dt)
end

function love.draw()
    sceneManager:draw()
    love.graphics.print(qqq)
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
