PictureScene = Class{__includes = {Scene, IObserver, IOnSceneEnd, IOnSceneBegin}}

function PictureScene:init(imagePath, opts)
    self.opts = opts or {}
    self.image = love.graphics.newImage(imagePath)
    self.rotation = 0
    self.angleSpeed = 1
    self.myGUI = GUI:load()

    table.insert(allGUI, self.myGUI)
    self.but = self.myGUI:checkbox("Next scene", {x = 100, y = 100})
end

function PictureScene:SetNextScene(nextScene)
    self.nextScene = nextScene
end

function PictureScene:update(dt)
    self.rotation = self.rotation + self.angleSpeed * dt

    if self.rotation >= 2*math.pi then
        self.rotation = 0
    end

    self.myGUI:update(dt)
    Scene.update(self, dt)
end

function PictureScene:draw()
    local w, h = love.window.getMode()
    local wt, ht = w / 2, h / 2

    love.graphics.push()
    love.graphics.translate(wt, ht)
    love.graphics.rotate(self.rotation)
    love.graphics.draw(self.image, -self.image:getWidth() / 2, -self.image:getHeight() / 2)
    love.graphics.translate(-wt, -ht)
    love.graphics.pop()

    self.myGUI:draw()
    Scene.draw(self)
end
