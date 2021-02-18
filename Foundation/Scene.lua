Scene = Class{__includes = {IOnSceneEnd, IOnSceneBegin}}

function Scene:init(imagePath)
    self.fadeTime = 0.3
    self.timer = Timer()
    self.alpha = 1
    self.image = love.graphics.newImage(imagePath)
end

function Scene:Enable()
    self.timer = Timer()
    sceneManager.OnSceneEnd[self] = self
    sceneManager.OnSceneBegin[self] = self
end

function Scene:Disable()
    sceneManager.OnSceneEnd[self] = nil
    sceneManager.OnSceneBegin[self] = nil
end

function Scene:update(dt)
    self.timer:update(dt)
end

function Scene:draw()
    love.graphics.draw(self.image)

    if self.alpha > 0 then
        love.graphics.setColor(1,0,0,self.alpha)
        love.graphics.rectangle("fill", 0, 0, 1000, 1000)
        love.graphics.setColor(1,1,1,1)
    end
end

function Scene:OnSceneEndDo()
    IOnSceneEnd.OnSceneEndDo(self)
    self.timer:tween(self.fadeTime * (1 - self.alpha), self, {alpha = 1}, "linear", function()
        self.OnSceneEndCompleted = true
    end)
end


function Scene:OnSceneBeginDo()
    IOnSceneBegin.OnSceneBeginDo(self)
    self.timer:tween(self.fadeTime * self.alpha, self, {alpha = 0}, "linear", function()
        self.OnSceneBeginCompleted = true
    end)
end
