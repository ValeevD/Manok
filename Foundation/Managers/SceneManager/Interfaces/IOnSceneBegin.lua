IOnSceneBegin = Class{
    OnSceneBeginCompleted = true,
}

function IOnSceneBegin:OnSceneBeginDo()
    self.OnSceneBeginCompleted = false
end
