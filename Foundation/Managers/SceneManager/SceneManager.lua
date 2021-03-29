SceneManager = Class{}

local SceneStateStatus = {["None"] = 1, ["Begin"] = 2, ["Unload"] = 3, ["Process"] = 4, ["End"] = 5}

function SceneManager:init()
    self.currentScene  = Scene()
    self.sceneToChange = Scene()
    self.onSceneEnd = {}
    self.onSceneBegin = {}
    self.onCurrentSceneUnload = {}
    self.state = SceneStateStatus.None
end

function SceneManager:LoadScene(scene)
    self.sceneToChange = scene
    self:BeginLoadingScene()

    soundManager.musicChannel:StopAllSounds()
end

function SceneManager:BeginLoadingScene()
    self.state = SceneStateStatus.Begin

    for _,v in pairs(self.onSceneEnd) do v() end
end

function SceneManager:EndLoadingScene()
    self.currentScene:OnDisable()
    self.currentScene = self.sceneToChange
    self.currentScene:OnEnable()

    self.state = SceneStateStatus.End

    for _,v in pairs(self.onSceneBegin) do v() end
end

function SceneManager:UnloadScene()
    self.state = SceneStateStatus.Unload

    for _,v in pairs(self.onCurrentSceneUnload) do v() end
end

function SceneManager:ProcessStageChanging()
    if self.state == SceneStateStatus.Begin then
        if self:CheckOnSceneEndCompleted() then
            self:EndLoadingScene()
        end
    elseif self.state == SceneStateStatus.Unload then
        if self:CheckOnSceneUnloadCompleted() then
            self:UnloadScene()
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

function SceneManager:CheckOnSceneUnloadCompleted()
    for k,_ in pairs(self.onCurrentSceneUnload) do
        if not k.OnSceneUnloadCompleted then
            return false
        end
    end

    return true
end

function SceneManager:update(dt)
    self:ProcessStageChanging()


    cameraManager:update(dt)
    self.currentScene:update(dt)
end

function SceneManager:draw()
    self.currentScene:draw()
end

function SceneManager:mousepressed(...)
    self.currentScene:mousepressed(...)
end

function SceneManager:mousereleased(...)
    self.currentScene:mousereleased(...)
end

function SceneManager:keypressed(key)
    self.currentScene:keypressed(key)
end

function SceneManager:textinput(key)
    self.currentScene:textinput(key)
end
