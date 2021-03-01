SceneManager = Class{}

local SceneStateStatus = {["None"] = 1, ["Begin"] = 2, ["Process"] = 3, ["End"] = 4}

function SceneManager:init()
    self.currentScene  = Scene()
    self.sceneToChange = Scene()
    self.onSceneEnd = {}
    self.onSceneBegin = {}
    self.state = SceneStateStatus.None
end

function SceneManager:LoadScene(scene)
    self.sceneToChange = scene
    self:BeginLoadingScene()
end

function SceneManager:BeginLoadingScene()
    self.state = SceneStateStatus.Begin

    for _,v in pairs(self.onSceneEnd) do
        v()
    end
end

function SceneManager:EndLoadingScene()
    self.currentScene:OnDisable()
    self.currentScene = self.sceneToChange
    self.currentScene:OnEnable()

    self.state = SceneStateStatus.End

    for _,v in pairs(self.onSceneBegin) do
        v()
    end
end

function SceneManager:ProcessStageChanging()
    if self.state == SceneStateStatus.Begin then
        if self:CheckOnSceneEndCompleted() then
            self:EndLoadingScene()
        end
    elseif self.state == SceneStateStatus.End then
        if self:CheckOnSceneBeginCompleted() then
            self.state = SceneStateStatus.None
        end
    end
end

function SceneManager:CheckOnSceneEndCompleted()
    for k,_ in pairs(self.onSceneEnd) do
        if not k.OnSceneEndCompleted then
            return false
        end
    end

    return true
end

function SceneManager:CheckOnSceneBeginCompleted()
    for k,_ in pairs(self.onSceneBegin) do
        if not k.OnSceneBeginCompleted then
            return false
        end
    end

    return true
end

function SceneManager:update(dt)
    self:ProcessStageChanging()

    self.currentScene:update(dt)
end

function SceneManager:draw()
    self.currentScene:draw()
end

function SceneManager:mousepressed(...)
    self.currentScene:mousepressed(...)
end

function SceneManager:keypressed(key)
    self.currentScene:keypressed(key)
end

function SceneManager:textinput(key)
    self.currentScene:textinput(key)
end
