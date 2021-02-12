Class = require("lib/hump/class")

GameManager = Class{}

function GameManager:init()
    Input = require("lib/input")
    Signal = require("lib/hump/signal")

    require("game/input/InputManager")
    require("game/input/InputHandler")
    require("game/testing/square")
    require("game/testing/ControlPoint")
    require("game/testing/SquareControlPoint")

    self.InputManager = InputManager()
    self.SceneManager = SceneManager()

    self.objectsToDraw = {}

    local sqr  = Square(10, 10)
    local sqr2 = Square(30, 30)

    table.insert(self.objectsToDraw, sqr)
    table.insert(self.objectsToDraw, sqr2)

    local scp  = SquareControlPoint(sqr)
    local scp2 = SquareControlPoint(sqr2)

    local ih   = InputHandler()

    ih:PushControlPoint(scp)
    ih:PushControlPoint(scp2)

    self.InputManager:PushHandler(ih)
end

function GameManager:update(dt)
    self.InputManager:update(dt)
end

function GameManager:draw()
    love.graphics.print("x: "..self.InputManager.target.target.controlObject.x..", y: "..self.InputManager.target.target.controlObject.y)

    for _, v in ipairs(self.objectsToDraw) do
        v:draw()
    end
end
