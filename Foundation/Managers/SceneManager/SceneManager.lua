SceneManager = Class{}

local SceneStateStatus = {"None", "Begin", "Process", "End"}

function SceneManager:init()
    self.currentScene = EmptyScene()
    self.sceneToChange = EmptyScene()
    self.OnSceneEnd = {}
    self.OnSceneBegin = {}
    self.state = "None"
end

function SceneManager:LoadScene(scene)
    self.sceneToChange = scene
    self:BeginLoadingScene()
end

function SceneManager:BeginLoadingScene()
    self.state = "Begin"
    self.currentScene:Enable()

    for k,v in pairs(self.OnSceneEnd) do
        v:OnSceneEndDo()
    end
end

function SceneManager:EndLoadingScene()
    self.currentScene:Disable()
    self.currentScene = self.sceneToChange
    self.currentScene:Enable()

    self.state = "End"

    for k,v in pairs(self.OnSceneBegin) do
        v:OnSceneBeginDo()
    end
end

function SceneManager:update(dt)
    if self.state == "Begin" then
        if self:CheckOnSceneEndCompleted() then
            self:EndLoadingScene()
        end
    elseif self.state == "End" then
        if self:CheckOnSceneBeginCompleted() then
            self.state = "None"
        end
    end
    self.currentScene:update(dt)
end

function SceneManager:draw()
    self.currentScene:draw()
end

function SceneManager:CheckOnSceneEndCompleted()
    for k,v in pairs(self.OnSceneEnd) do
        if not v.OnSceneEndCompleted then
            return false
        end
    end

    return true
end

function SceneManager:CheckOnSceneBeginCompleted()
    for k,v in pairs(self.OnSceneBegin) do
        if not v.OnSceneBeginCompleted then
            return false
        end
    end

    return true
end
