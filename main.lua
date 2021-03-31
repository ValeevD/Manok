function love.load()
    ind = 0
    px, py = 0, 0
    require("Foundation/GameInitializer")
    gdir = Vector(0,0)

    cameraManager = CameraManager()
    sceneManager = SceneManager()
    soundManager = SoundManager()

    notificationManager = NotificationManager()

    inputManager = InputManager()
    scene1 = PictureScene(backGroundSource1)
    scene2 = PictureScene(backGroundSource2)

    scene1:SetNextScene(scene2)
    scene2:SetNextScene(scene1)

    sceneManager:LoadScene(scene1)

    input = Input()

    input:bind("mouse1", "mouse1")
    input:bind("space", "space")
    input:bind("w", "up")
    input:bind("s", "down")
    input:bind("a", "left")
    input:bind("d", "right")

    newMap = cartographer.load("resources/Spritesheet/tilemap.lua")
end

function love.update(dt)
    soundManager:update(dt)
    sceneManager:update(dt)
    newMap:update(dt)
end

function love.draw()
    sceneManager:draw()

    love.graphics.setColor(0,0,0)
    love.graphics.print(px)
    love.graphics.print(py, 0, 10)

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
