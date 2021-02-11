Square = Class{}

function Square:init(x, y)
    self.x, self.y = x, y

    self.speed = 60
end

function Square:draw()
    love.graphics.rectangle("line", self.x, self.y, 20, 20)
end

function Square:moveVertical(dt, direction)
    self.y = self.y + self.speed * dt * (direction or 1)
end

function Square:moveUp(dt)
    self:moveVertical(dt, -1)
end

function Square:moveDown(dt)
    self:moveVertical(dt)
end

function Square:moveHorisontal(dt, direction)
    self.x = self.x + self.speed * dt * (direction or 1)
end

function Square:moveRight(dt)
    self:moveHorisontal(dt)
end

function Square:moveLeft(dt)
    self:moveHorisontal(dt, -1)
end
