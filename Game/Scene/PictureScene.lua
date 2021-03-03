PictureScene = Class{__includes = {IObserver, Scene}}

function PictureScene:init(imagePath, opts)
    Scene.init(self)

    self.opts = opts or {}
    self.image = love.graphics.newImage(imagePath)
    self.rotation = 0
    self.angleSpeed = 1
    self:FillUI()
end

function PictureScene:FillUI()
    local mainState = SceneState()
    local newState = SceneState()

    local newCanvas = NewGUI()
    local newCanvas2 = NewGUI()

    newCanvas:Observe(mainState.onUpdate, newCanvas.update)
    newCanvas2:Observe(newState.onUpdate, newCanvas2.update)

    newCanvas:Observe(mainState.onActivate, function()
        local newButton = newCanvas:button("Next state", {math.random(30, 600), math.random(30, 600), 128, Gspot.style.unit})
        newButton.click = function(this)
            self.stateManager:Push(newState)
            self.UI:Push(newCanvas2)
        end
    end)

    newCanvas2:Observe(newState.onActivate, function()
        local newButton2 = newCanvas2:button("Close state", {55, 55, 128, Gspot.style.unit})
        newButton2.click = function(this)
            sceneManager:LoadScene(self.nextScene)
        end
    end)

    self.stateManager:Push(mainState)
    self.UI:Push(newCanvas)
end

function PictureScene:OnDisable()
    local n = #self.stateManager.states
    while n > 1 do
        self.stateManager:Pop()
        n = n - 1
    end

    n = #self.UI.canvasList
    while n > 1 do
        self.UI:Pop()
        n = n - 1
    end

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
