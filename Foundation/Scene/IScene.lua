IScene = Class{
    gameObjects = {},
}

function IScene:init()
    self.guiController = guiManager:NewGUI()
end

function IScene:OnEnable()
end

function IScene:OnDisable()
end

function IScene:update(dt)
end

function IScene:draw()
end
