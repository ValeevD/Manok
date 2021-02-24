IOnSceneEnd = Class{
    OnSceneEndCompleted = true,
    handlers = {}
}

function IOnSceneEnd:Release(func)
    self.OnSceneEndCompleted = false

    return func
end
