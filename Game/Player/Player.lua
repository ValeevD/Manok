Player = Class()

function Player:init(x, y, opts)
    self.x = x
    self.y = y
    self.direction = Vector(0, 0)
    self.look = Vector(0, 0)
    self.speed = 0
    self.acceleration = 200
    self.maxSpeed = 100
    self.frameRate = 0.05

    self.playerIndex = 1

    self.spriteSheet = love.graphics.newImage(opts.imagePath)
    self.playerInput = PlayerInput()
    inputManager:Register(self)

    self.playerMoveInput = PlayerMovementInput(self, opts.sceneState)
    self.playerShootInput = PlayerShootInput(self, opts.sceneState)
    self.playerLookInput = PlayerLookInput(self, opts.sceneState)

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
    --self.animation_ = {update = function(dt) end, draw = function(a,b,c) end, gotoFrame = function(a) end}

    self.animation = self.animation_right
end

function Player:update(dt)
    gdir = self.look
    local leftright, updown = "", ""

    if self.look.x ~= 0 then leftright = self.look.x == 1 and "right" or "left" end
    if self.look.y ~= 0 then updown = self.look.y == 1 and "up" or "down" end

    local prevAnim = self.animation
    self.animation = self["animation_"..leftright..updown] or self.animation

    if self.speed ~= 0 then
        if self.animation then self.animation:update(dt) end
    else
        self.animation:gotoFrame(3)
    end

    camera:lookAt(self.x, self.y)
end

function Player:draw()
    if self.animation then self.animation:draw(self.spriteSheet, self.x, self.y) end
end
