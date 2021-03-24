Bullet = Class{__includes = {ITweener}}

function Bullet:init(x, y, direction)
    ITweener.init(self)

    self.x, self.y = x, y
    local pos_x, pos_y = love.mouse.getPosition()
    local wid, hei = love.graphics.getWidth(), love.graphics.getHeight()

    pos_x = camera.x + (pos_x - wid / 2)
    pos_y = camera.y + (pos_y - hei / 2)
    self.direction = (Vector(pos_x, pos_y) - Vector(self.x, self.y)):normalized()

    self.direction.y = -self.direction.y
    --self.direction = direction:clone()
    self.r = 7
    self.duration = 1
    self.speed = 20
    self.isDead = false

    self.timer:tween(self.duration, self, {r = 0}, "linear", function() self.isDead = true end)
end

function Bullet:update(dt)
    self.timer:update(dt)

    self.x = self.x + self.direction.x * self.speed
    self.y = self.y - self.direction.y * self.speed
end

function Bullet:draw()
    local r, g, b, a = love.graphics.getColor()

    love.graphics.setColor(0,0,0)
    love.graphics.circle("fill", self.x, self.y, self.r)
    love.graphics.setColor(r, g, b, a)
end
