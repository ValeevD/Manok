PictureScene = Class{__includes = {Scene, IObserver, IOnSceneEnd, IOnSceneBegin}}

function PictureScene:init(imagePath, opts)
    Scene.init(self)
    self.opts = opts or {}
    self.image = love.graphics.newImage(imagePath)
    self.rotation = 0
    self.angleSpeed = 1
    self:FillGUI()
end

function PictureScene:FillGUI()
    local guiController = guiManager:NewGUI()
    guiController:button("Next scene", {x = 80, y = 80, w = 128, h = GUI.style.unit})
    .click = function(...)
        sceneManager:LoadScene(self.nextScene)
    end
    self.guiController = guiController
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

    self.guiController:update(dt)
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

    self.guiController:draw()
    Scene.draw(self)
end
