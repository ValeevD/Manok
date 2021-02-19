Scene = Class{__includes = {IOnSceneEnd, IOnSceneBegin}}

function Scene:init(imagePath)
    self.image = love.graphics.newImage(imagePath)

    self.timer = Timer()

    self.alpha    = 1
    self.fadeTime = 0.3

    self.handlers = {}
    self.observerLists = {}
end

function Scene:Observe(observerList, func)
    table.insert(self.observerLists, observerList)

    observerList[self] = func
end

function Scene:Enable()
    self:Observe(sceneManager.OnSceneEnd, IOnSceneEnd.Release(self, function ()
        table.insert(self.handlers, self.timer:tween(self.fadeTime * (1 - self.alpha), self, {alpha = 1}, "linear", function()
            self.OnSceneEndCompleted = true
        end))
    end))

    self:Observe(sceneManager.OnSceneBegin, IOnSceneBegin.Release(self, function()
        table.insert(self.handlers, self.timer:tween(self.fadeTime * self.alpha, self, {alpha = 0}, "linear", function()
            self.OnSceneBeginCompleted = true
        end))
    end))
end

function Scene:Disable()
    for _,v in ipairs(self.handlers) do
        self.timer:cancel(v)
    end

    for _,v in ipairs(self.observerLists) do
        v[self] = nil
    end
end

function Scene:update(dt)
    self.timer:update(dt)
end

function Scene:draw()
    love.graphics.draw(self.image)

    if self.alpha > 0 then
        love.graphics.setColor(0,0,0,self.alpha)
        love.graphics.rectangle("fill", 0, 0, 1000, 1000)
        love.graphics.setColor(1,1,1,1)
    end
end
