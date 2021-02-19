SceneManager = Class{}

local SceneStateStatus = {["None"] = 1, ["Begin"] = 2, ["Process"] = 3, ["End"] = 4}

function SceneManager:init()
    self.currentScene  = EmptyScene()
    self.sceneToChange = EmptyScene()
    self.OnSceneEnd = {}
    self.OnSceneBegin = {}
    self.state = SceneStateStatus.None
end

function SceneManager:LoadScene(scene)
    self.sceneToChange = scene
    self:BeginLoadingScene()
end

function SceneManager:BeginLoadingScene()
    self.state = SceneStateStatus.Begin
    self.currentScene:Enable()

    for _,v in pairs(self.OnSceneEnd) do
        v()
    end
end

function SceneManager:EndLoadingScene()
    self.currentScene:Disable()
    self.currentScene = self.sceneToChange
    self.currentScene:Enable()

    self.state = SceneStateStatus.End

    for _,v in pairs(self.OnSceneBegin) do
        v()
    end
end

function SceneManager:update(dt)
    if self.state == SceneStateStatus.Begin then
        if self:CheckOnSceneEndCompleted() then
            self:EndLoadingScene()
        end
    elseif self.state == SceneStateStatus.End then
        if self:CheckOnSceneBeginCompleted() then
            self.state = SceneStateStatus.None
        end
    end
    self.currentScene:update(dt)
end

function SceneManager:draw()
    self.currentScene:draw()
end

function SceneManager:CheckOnSceneEndCompleted()
    for k,_ in pairs(self.OnSceneEnd) do
        if not k.OnSceneEndCompleted then
            return false
        end
    end

    return true
end

function SceneManager:CheckOnSceneBeginCompleted()
    for k,_ in pairs(self.OnSceneBegin) do
        if not k.OnSceneBeginCompleted then
            return false
        end
    end

    return true
end
