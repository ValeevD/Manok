function love.load()
    require("Foundation/GameInitializer")
    sceneManager = SceneManager()

    scene1 = Scene("Foundation/Testing/rasstrelirt.jpg")
    scene2 = Scene("Foundation/Testing/cat.png")

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
