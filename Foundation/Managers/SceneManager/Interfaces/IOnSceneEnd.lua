IOnSceneEnd = Class{
    OnSceneEndCompleted = true,
}

function IOnSceneEnd:OnSceneEndDo()
    self.OnSceneEndCompleted = false
end
