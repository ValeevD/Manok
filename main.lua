function love.load()
    require("Foundation/GameInitializer")
    sceneManager = SceneManager()

    allGUI = {}

    scene1 = PictureScene("resources/fire.png")
    scene2 = PictureScene("resources/water.png")

    scene1:SetNextScene(scene2)
    scene2:SetNextScene(scene1)

    table.insert(scene1.gameObjects, FadingScreen())
    table.insert(scene2.gameObjects, FadingScreen())

    sceneManager:LoadScene(scene1)

    ind = 0
    qqq = 0

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
    sceneManager:draw()
end

function love.mousepressed(...)
    for _,v in ipairs(allGUI) do
        v:mousepress(...)
    end
end

function love.keypressed(key)
    for _,v in ipairs(allGUI) do
        v:keypress(key)
    end
end

function love.textinput(key)
    for _,v in ipairs(allGUI) do
        v:textinput(key)
    end
end
