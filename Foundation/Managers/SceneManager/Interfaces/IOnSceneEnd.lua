IOnSceneEnd = Class{__includes = {ITweener}}

function IOnSceneEnd:init()
    self.OnSceneEndCompleted = true

    ITweener.init(self)
end

function IOnSceneEnd:Release(func)
    self.OnSceneEndCompleted = false

    return func
end
