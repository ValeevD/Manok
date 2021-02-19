IOnSceneBegin = Class{
    OnSceneBeginCompleted = true,
}

function IOnSceneBegin:Release(func)
    self.OnSceneBeginCompleted = false

    return func
end
