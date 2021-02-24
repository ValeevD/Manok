function love.load()
    require("Foundation/GameInitializer")
    sceneManager = SceneManager()

    scene1 = SimpleScene({color = {1,0,0,0.5}})
    scene2 = SimpleScene({color = {0,1,0,0.5}})

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
        qqq = 0
        if ind == 0 then
            sceneManager:LoadScene(scene2)
            ind = 1
        else
            sceneManager:LoadScene(scene1)
            ind = 0
        end
    end

    qqq = qqq + 1
    sceneManager:update(dt)
end

function love.draw()
    sceneManager:draw()
end
