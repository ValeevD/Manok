IOnSceneEnd = Class{}

function IOnSceneEnd:init()
    self.OnSceneEndCompleted = true
    self.handlers = {}
end

function IOnSceneEnd:Release(func)
    self.OnSceneEndCompleted = false

    return func
end
