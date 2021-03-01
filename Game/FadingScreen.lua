FadingScreen = Class{__includes = {IObserver, IOnSceneEnd, IOnSceneBegin}}

function FadingScreen:init()
    self.timer = Timer()

    self.alpha    = 1
    self.fadeTime = 0.3

    IObserver.init(self)
    IOnSceneEnd.init(self)
    IOnSceneBegin.init(self)
end

function FadingScreen:OnEnable()
    self:Observe(sceneManager.onSceneEnd, IOnSceneEnd.Release(self, function ()
        table.insert(self.handlers, self.timer:tween(self.fadeTime * (1 - self.alpha), self, {alpha = 1}, "linear", function()
            self.OnSceneEndCompleted = true
        end))
    end))

    self:Observe(sceneManager.onSceneBegin, IOnSceneBegin.Release(self, function()
        table.insert(self.handlers, self.timer:tween(self.fadeTime * self.alpha, self, {alpha = 0}, "linear", function()
            self.OnSceneBeginCompleted = true
        end))
    end))
end

function FadingScreen:OnDisable()
    for _,v in ipairs(self.handlers) do
        self.timer:cancel(v)
    end

    for _,v in ipairs(self.observerLists) do
        v[self] = nil
    end
end

function FadingScreen:update(dt)
    self.timer:update(dt)
end

function FadingScreen:draw()
    if self.alpha > 0 then
        love.graphics.setColor(0,0,0,self.alpha)
        love.graphics.rectangle("fill", 0, 0, 1000, 1000)
        love.graphics.setColor(1,1,1,1)
    end
end
