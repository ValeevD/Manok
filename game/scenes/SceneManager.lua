SceneManager = Class{}

function SceneManager:init()
    self.currentScene = nil
    self.sceneLoaded = false
    self.signal = Signal()
end

function SceneManager:LoadScene(scene)
    self.signal:emit("OnSceneEnd")
    self.currentScene = scene
    self.signal:emit("OnSceneBegin")
end

function SceneManager:RegisterOnSceneEnd(func)
    self.signal:register("OnSceneEnd", func)
end

function SceneManager:RegisterOnSceneBegin(func)
    self.signal:register("OnSceneBegin", func)
end

function SceneManager:RegisterOnSceneProcess(func)
    self.signal:register("OnSceneProcess", func)
end
