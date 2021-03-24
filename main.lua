function love.load()
    ind = 0
    qqq = 0
    require("Foundation/GameInitializer")
    gdir = Vector(0,0)

    sceneManager = SceneManager()
    soundManager = SoundManager()

    inputManager = InputManager()
    scene1 = PictureScene("resources/fire.png", backGroundSource1)
    scene2 = PictureScene("resources/water.png", backGroundSource2)

    scene1:SetNextScene(scene2)
    scene2:SetNextScene(scene1)

    sceneManager:LoadScene(scene1)

    input = Input()
    input:bind("mouse1", "mouse1")
    input:bind("w", "up")
    input:bind("s", "down")
    input:bind("a", "left")
    input:bind("d", "right")

    camera = Camera(0, 0)
end

function love.update(dt)
    soundManager:update(dt)
    sceneManager:update(dt)
end

function love.draw()

    sceneManager:draw()

    love.graphics.setColor(0,0,0)
    --love.graphics.print("x: "..gdir.x..", y: "..gdir.y)
    love.graphics.print(qqq)
    love.graphics.setColor(1,1,1)

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
