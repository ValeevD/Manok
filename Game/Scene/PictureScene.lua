PictureScene = Class{__includes = {Scene}}

function PictureScene:init(imagePath, opts)
    Scene.init(self)

    self.opts = opts or {}
    self.image = love.graphics.newImage(imagePath)
    self.rotation = 0
    self.angleSpeed = 1
    self:FillUI()
end

function PictureScene:FillUI()
    --uIController:group("Next state", {math.random(0, 300), math.random(0, 300)})

    local newCanvas = self.UI:NewCanvas()

    newCanvas:button("Next scene", {math.random(30, 100), math.random(30, 100), 128, UI.style.unit})
    .click = function(...)
        sceneManager:LoadScene(self.nextScene)
    end
    qqq = qqq + 1

    self.UI:Push(newCanvas)
end

function PictureScene:OnEnable()
    Scene.OnEnable(self)
end

function PictureScene:OnDisable()
    Scene.OnDisable(self)
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
