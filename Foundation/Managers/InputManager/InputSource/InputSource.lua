InputSource = Class()

function InputSource:init(playerInput)
    self.playerInput = playerInput
end

function InputSource:Dispose()
    self:DisconnectAllActions()
end

function InputSource:DisconnectAllActions()
    if self.playerInput == nil then
        return
    end

    for k,v in pairs(self.playerInput.actions) do
        v:Dispose()
    end
end

function InputSource:Action(name)
    return self.playerInput:FindAction(name)
end
