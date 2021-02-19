IOnSceneEnd = Class{
    OnSceneEndCompleted = true,
}

function IOnSceneEnd:Release(func)
    self.OnSceneEndCompleted = false

    return func
end
