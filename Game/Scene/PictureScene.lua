PictureScene = Class{__includes = {Scene}}

function PictureScene:init(imagePath, opts)
    Scene.init(self)

    self.opts = opts or {}
    self.image = love.graphics.newImage(imagePath)
    self.rotation = 0
    self.angleSpeed = 10
    self:FillUI()
end

function PictureScene:FillUI()
    local newCanvas = Gspot:load()

    newCanvas:button("Next scene", {math.random(30, 600), math.random(30, 600), 128, Gspot.style.unit})
    .click = function(...)
        sceneManager:LoadScene(self.nextScene)
    end

    self._UI:Push(newCanvas)
end

function PictureScene:SetNextScene(nextScene)
    self.nextScene = nextScene
end

function PictureScene:update(dt)
    self.rotation = self.rotation + self.angleSpeed * dt

    if self.rotation >= 2*math.pi then
        self.rotation = 0
    end

    Scene.update(self, dt)
end

function PictureScene:draw()
    local w, h = love.window.getMode()
    local wt, ht = w / 2, h / 2

    love.graphics.push()
    love.graphics.translate(wt, ht)
    love.graphics.rotate(self.rotation)
    love.graphics.draw(self.image, -self.image:getWidth() / 2, -self.image:getHeight() / 2)
    love.graphics.pop()

    Scene.draw(self)
end
