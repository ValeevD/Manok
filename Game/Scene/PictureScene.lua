PictureScene = Class{__includes = {Scene}}

function PictureScene:init(imagePath, opts)
    Scene.init(self)

    self.opts = opts or {}
    self.image = love.graphics.newImage(imagePath)
    self.rotation = 0
    self.angleSpeed = 1
    self.mainState = SceneState()
    self.newState = SceneState()
    self:FillUI()
end

function PictureScene:FillUI()
    self.mainState = SceneState()
    self.stateManager:Push(self.mainState)

    self.newState = SceneState()
    --self.newState.updateParentState = true

    local newCanvas = Gspot:load()
    local newCanvas2 = Gspot:load()

    table.insert(self.mainState.onUpdate, function(dt) newCanvas:update(dt) end)
    local newButton = newCanvas:button("Next state", {math.random(30, 600), math.random(30, 600), 128, Gspot.style.unit})
    newButton.click = function(this)
        self.stateManager:Push(self.newState)
        self.UI:Push(newCanvas2)
    end

    table.insert(self.newState.onUpdate, function(dt) newCanvas2:update(dt) end)
    local newButton2 = newCanvas2:button("Close state", {55, 55, 128, Gspot.style.unit})
    newButton2.click = function(this)
        self.stateManager:Pop(self.newState)
        self.UI:Pop(newCanvas2)
    end

    self.UI:Push(newCanvas)
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
