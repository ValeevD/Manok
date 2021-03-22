Player = Class()

function Player:init(x, y, opts)
    self.x = x
    self.y = y
    self.direction = Vector(0, 0)
    self.speed = 0
    self.acceleration = 200
    self.maxSpeed = 100
    self.frameRate = 0.05

    self.spriteSheet = love.graphics.newImage(opts.imagePath)

    local imgWidth, imgHeight = self.spriteSheet:getWidth(), self.spriteSheet:getHeight()
    local grid = Anim8.newGrid(64, 64, imgWidth, imgHeight)


    self.animation_right = Anim8.newAnimation(grid("1-16", 3), self.frameRate)
    self.animation_rightup = Anim8.newAnimation(grid("1-16", 4), self.frameRate)
    self.animation_up = Anim8.newAnimation(grid("1-16", 5), self.frameRate)
    self.animation_leftup = Anim8.newAnimation(grid("1-16", 6), self.frameRate)
    self.animation_left = Anim8.newAnimation(grid("1-16", 7), self.frameRate)
    self.animation_leftdown = Anim8.newAnimation(grid("1-16", 8), self.frameRate)
    self.animation_down = Anim8.newAnimation(grid("1-16", 1), self.frameRate)
    self.animation_rightdown = Anim8.newAnimation(grid("1-16", 2), self.frameRate)

    self.animation = self.animation_right
end

function Player:update(dt)
    local vector = Vector(0, 0)

    if input:down("up") then vector.y = vector.y - 1 end
    if input:down("down") then vector.y = vector.y + 1 end
    if input:down("left") then vector.x = vector.x - 1 end
    if input:down("right") then vector.x = vector.x + 1 end

    local normVector = vector:normalized()

    if normVector.x ~= 0 or normVector.y ~= 0 then

        self.speed = math.min(self.maxSpeed, self.speed + self.acceleration * dt)
        local leftright, updown = "", ""

        if vector.x ~= 0 then leftright = vector.x == 1 and "right" or "left" end
        if vector.y ~= 0 then updown = vector.y == -1 and "up" or "down" end

        self.animation = self["animation_"..leftright..updown]

        if self.animation then self.animation:update(dt) end

        self.direction = normVector
    else
        self.animation:gotoFrame(3)
        self.speed = 0
    end

    normVector = normVector * self.speed

    self.x = self.x + normVector.x * dt
    self.y = self.y + normVector.y * dt
end

function Player:draw()
    -- love.graphics.circle("line", self.x, self.y, 15)
    -- love.graphics.line(self.x, self.y, self.x + self.direction.x * 50, self.y - self.direction.y * 50)
    if self.animation then self.animation:draw(self.spriteSheet, self.x, self.y) end
end
