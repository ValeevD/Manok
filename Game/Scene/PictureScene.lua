PictureScene = Class{__includes = {IObserver, Scene, IOnSceneBegin, IOnSceneEnd}}

function PictureScene:init(imagePath, opts)
    Scene.init(self)
    IObserver.init(self)
    IOnSceneBegin.init(self)
    IOnSceneEnd.init(self)

    self.opts = opts or {}
    self.image = love.graphics.newImage(imagePath)
    self.rotation = 0
    self.angleSpeed = 1

    self.mainState = SceneState()
    self.newState = SceneState()

    table.insert(self.gameObjects, FadingScreen())
end

function PictureScene:FillUI()
    local newCanvas = NewGUI()
    local newCanvas2 = NewGUI()

    newCanvas
    :Observe(self.mainState.onUpdate, function(dt)
        newCanvas:update(dt)
    end)
    :Observe(self.mainState.onActivate, function()
        local newButton = newCanvas:button("Next state", {math.random(30, 600), math.random(30, 600), 128, Gspot.style.unit})
        newButton.click = function(this)
            love.audio.play(clickSource)
            self.stateManager:Push(self.newState)
            self.UI:Push(newCanvas2)
        end
    end)
    :Observe(self.mainState.onDeactivate, function()
        newCanvas:OnDisable()
    end)

    newCanvas2
    :Observe(self.newState.onUpdate, function(dt)
        newCanvas2:update(dt)
    end)
    :Observe(self.newState.onActivate, function()
        local newButton2 = newCanvas2:button("Close state", {55, 55, 128, Gspot.style.unit})
        newButton2.click = function(this)
            love.audio.play(clickSource)
            self.stateManager:Pop(self.newState)
            self.UI:Pop(newCanvas2)
        end
    end)

    local fadingScreen = FadingScreen()

    self.stateManager:Push(self.mainState)
    self.UI:Push(newCanvas)
end

function PictureScene:OnEnable()
    self:FillUI()
    Scene.OnEnable(self)
end

function PictureScene:OnDisable()
    for i = 1, #self.stateManager.states do
        self.stateManager:Pop()
    end

    for i = 1, #self.UI.canvasList do
        self.UI:Pop()
    end

    for _,v in ipairs(self.handlers) do
        self.timer:cancel(v)
    end
    self.handlers = {}

    IObserver.OnDisable(self)
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
