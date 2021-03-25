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

    self.player = Player(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, {imagePath = "resources/Small.png", sceneState = self.mainState})

    table.insert(self.gameObjects, self.player)
    table.insert(self.gameObjects, FadingScreen())

    currentCanvas = nil
end

function PictureScene:FillUI()
    local newCanvas = NewGUI(self.mainState)
    local newCanvas2 = NewGUI(self.newState)

    currentCanvas = newCanvas

    newCanvas--Observing
    :Observe(self.mainState.onUpdate, function(dt)
        newCanvas:update(dt)
    end)
    :Observe(self.mainState.onActivate, function()
        local newButton = newCanvas:button("Next state", {300, 300, 128, Gspot.style.unit})
        newButton.click = function(this)
            soundManager.sfxChannel:Play(clickSource:clone())
            self.stateManager:Push(self.newState)
            self.UI:Push(newCanvas2)
            currentCanvas = newCanvas2
        end

        local scrll = newCanvas:scroll(nil, {50, 50, h = 100}, nil, {0, 100, (1 - soundManager.musicChannel.volume) * 100, 1, 'vertical'})
        scrll:setshape('circle')
        scrll.update = function(this, dt)
            this.Gspot[this.elementtype].update(this, dt)
            soundManager.musicChannel:SetVolume((100 - this.values.current) / 100)
        end

        local scrll2 = newCanvas:scroll(nil, {150, 50, h = 100}, nil, {0, 100, (1 - soundManager.sfxChannel.volume) * 100, 1, 'vertical'})
        scrll2:setshape('circle')
        scrll2.update = function(this, dt)
            this.Gspot[this.elementtype].update(this, dt)
            soundManager.sfxChannel:SetVolume((100 - this.values.current) / 100)
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
            soundManager.sfxChannel:Play(clickSource:clone())
            self.stateManager:Pop(self.newState)
            self.UI:Pop(newCanvas2)
            currentCanvas = newCanvas
        end
    end)

    local fadingScreen = FadingScreen()

    self.stateManager:Push(self.mainState)
    self.UI:Push(newCanvas)
end

function PictureScene:OnEnable()
    soundManager:PlayMusic(self.opts:clone(), 0.1)

    --soundManager.musicChannel:PlayAt({x = 300, y = 300}, self.opts:clone(), true, true, 1)
    self:FillUI()
    Scene.OnEnable(self)--base
end

function PictureScene:OnDisable()
    for i = 1, #self.stateManager.states do
        self.stateManager:Pop()
    end

    for i = 1, #self.UI.canvasList do
        self.UI:Pop()
    end

    IObserver.OnDisable(self)--base
    Scene.OnDisable(self)--base
    IOnSceneBegin.Kill(self)
end

function PictureScene:SetNextScene(nextScene)
    self.nextScene = nextScene
end

function PictureScene:update(dt)
    -- self.rotation = self.rotation + self.angleSpeed * dt

    -- if self.rotation >= 2*math.pi then
    --     self.rotation = 0
    -- end

    Scene.update(self, dt)--base
    qqq = currentCanvas.blockMouseClick and "yes" or "no"
end

function PictureScene:draw()
    local w, h = love.window.getMode()
    local wt, ht = w / 2, h / 2


    -- love.graphics.push()
    -- love.graphics.translate(wt, ht)
    -- love.graphics.rotate(self.rotation)
    -- love.graphics.draw(self.image, -self.image:getWidth() / 2, -self.image:getHeight() / 2)
    -- love.graphics.pop()

    love.graphics.setColor(1,1,1,1)
    love.graphics.rectangle("fill", 0, 0, 1000, 1000)

    Scene.draw(self)--base
end
