Scene = Class{}

function Scene:init()
    self.gameObjects = {}
    self.UI = UIManager()
    self.stateManager = SceneStateManager()
end

function Scene:OnEnable()
    for _,v in ipairs(self.gameObjects) do
        if v.OnEnable then
            v:OnEnable()
        end
    end
end

function Scene:OnDisable()
    for _,v in ipairs(self.gameObjects) do
        if v.OnDisable then
            v:OnDisable()
        end
    end
end

function Scene:update(dt)
    self.stateManager:update(dt)
    for i = #self.gameObjects, 1, -1 do
        if not self.gameObjects[i] or self.gameObjects[i].isDead then
            table.remove(self.gameObjects, i)
        else
            self.gameObjects[i]:update(dt)
        end
    end
end

function Scene:draw()
    cameraManager:BeforeUpdate()
    newMap:draw()
    for _,v in ipairs(self.gameObjects) do
        v:draw(dt)
    end
    cameraManager:AfterUpdate()

    self.UI:draw()
end

function Scene:mousepressed(...)
    self.stateManager:mousepressed(...)
end

function Scene:mousereleased(...)
    self.stateManager:mousereleased(...)
end

function Scene:keypressed(key)
    self.stateManager:keypressed(key)
end

function Scene:textinput(key)
    self.stateManager:textinput(key)
end
