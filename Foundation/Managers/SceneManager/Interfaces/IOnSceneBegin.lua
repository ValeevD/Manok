IOnSceneBegin = Class{}

function IOnSceneBegin:init()
    self.OnSceneBeginCompleted = true
    self.handlers = {}
end

function IOnSceneBegin:Release(func)
    self.OnSceneBeginCompleted = false

    return func
end
