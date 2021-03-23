InputSource = Class()

function InputSource:init(playerInput)
    self.playerInput = playerInput
    self.actions = {}
end

function InputSource:Dispose()
    self:DisconnectAllActions()
end

function InputSource:DisconnectAllActions()
    for k,v in pairs(self.actions) do
        v:Dispose()
    end

    self.actions = {}
end

function InputSource:Action(name)
    local wrapper = self.actions[name]

    if wrapper then
        return wrapper
    end


end
