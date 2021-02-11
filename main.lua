function love.load()
    Class = require("lib/hump/class")
    Input = require("lib/input")

    require("game/inputmanager")
    require("game/testing/square")
    require("game/testing/ControlPoint")
    require("game/testing/SquareControlPoint")

    objectsToDraw = {}

    im  = InputManager()

    sqr  = Square(10, 10)
    sqr2 = Square(30, 30)


    table.insert(objectsToDraw, sqr)
    table.insert(objectsToDraw, sqr2)

    scp  = SquareControlPoint(sqr)
    scp2 = SquareControlPoint(sqr2)

    currentScp = scp

    im:PushControlPoint(scp)
end

function love.draw()
    love.graphics.print("x: "..im.target.controlObject.x..", y: "..im.target.controlObject.y)

    for _, v in ipairs(objectsToDraw) do
        v:draw()
    end
end

function love.update(dt)
    if input:pressed("space") then
        if #im.targetQueue == 1 then
            im:PushControlPoint(scp2)
        else
            im:PopControlPoint(scp2)
        end
    end

    im:update(dt)
end
