Scene = Class{__includes = {IScene, IObserver, IOnSceneEnd, IOnSceneBegin}}

function Scene:init(...)
    IScene.init(self, ...)
end

function Scene:OnEnable()
    guiManager:Push(self.guiController)
    for _,v in ipairs(self.gameObjects) do
        if v.OnEnable then
            v:OnEnable()
        end
    end
end

function Scene:OnDisable()
    guiManager:Pop(self.guiController)
    for _,v in ipairs(self.gameObjects) do
        if v.OnDisable then
            v:OnDisable()
        end
    end
end

function Scene:update(dt)
    for _,v in ipairs(self.gameObjects) do
        v:update(dt)
    end
end

function Scene:draw()
    for _,v in ipairs(self.gameObjects) do
        v:draw(dt)
    end
end
