function love.load()
    Game = require("game/GameManager")
    game = GameManager()
end

function love.draw()
    game:draw()
end

function love.update(dt)
    game:update(dt)
end
