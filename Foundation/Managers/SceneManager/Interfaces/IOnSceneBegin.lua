IOnSceneBegin = Class{
    OnSceneBeginCompleted = true,
    handlers = {}
}

function IOnSceneBegin:Release(func)
    self.OnSceneBeginCompleted = false

    return func
end
