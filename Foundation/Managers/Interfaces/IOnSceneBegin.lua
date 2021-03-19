IOnSceneBegin = Class{__includes = {ITweener}}

function IOnSceneBegin:init()
    self.OnSceneBeginCompleted = true

    ITweener.init(self)
end

function IOnSceneBegin:Release(func)
    self.OnSceneBeginCompleted = false

    return func
end
