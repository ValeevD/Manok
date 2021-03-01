Scene = Class{}

function Scene:init(...)
    self.gameObjects = {}
    self._UI = UIManager()
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
    self._UI:update(dt)

    for _,v in ipairs(self.gameObjects) do
        v:update(dt)
    end
end

function Scene:draw()
    self._UI:draw()

    for _,v in ipairs(self.gameObjects) do
        v:draw(dt)
    end
end

function Scene:mousepressed(...)
    self._UI:mousepressed(...)
end

function Scene:keypressed(key)
    self._UI:keypressed(key)
end

function Scene:textinput(key)
    self._UI:textinput(key)
end
