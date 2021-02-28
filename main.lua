function love.load()
    ind = 0
    qqq = 0
    require("Foundation/GameInitializer")
    -- uIManager = UIManager()
    sceneManager = SceneManager()

    scene1 = PictureScene("resources/fire.png")
    scene2 = PictureScene("resources/water.png")

    scene1:SetNextScene(scene2)
    scene2:SetNextScene(scene1)

    table.insert(scene1.gameObjects, FadingScreen())
    table.insert(scene2.gameObjects, FadingScreen())

    --scene1:OnEnable()
    sceneManager:LoadScene(scene1)

    input = Input()
    input:bind("space", "space")

end

function love.update(dt)
    if input:pressed("space") then
        if ind == 0 then
            sceneManager:LoadScene(scene2)
            ind = 1
        else
            sceneManager:LoadScene(scene1)
            ind = 0
        end
    end
    sceneManager:update(dt)
end

function love.draw()
    -- love.graphics.print(scene1.guiController and "yes" or "no")
    -- love.graphics.print(#uIManager.guiList, 0, 10)
    sceneManager:draw()
    love.graphics.print(qqq, 0, 20)
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
