SceneStateManager = Class{}

function SceneStateManager:init()
    self.currentState = nil

    self.states = {}
    self.statesCache = {}

    self.stateListChanged = false
end

function SceneStateManager:Push(newState)
    self.stateListChanged = true
    table.insert(self.states, newState)

    newState:Activate()
end

function SceneStateManager:Pop(state)
    self.stateListChanged = true

    for i = 1, #self.states do
        if state == self.states[i] then
            table.remove(self.states, i)
        end
    end

    if state == self.currentState then
        state:ResignTopmost()
        self.currentState = nil
    end

    state:Deactivate()
end

function SceneStateManager:CachedGameStates()
    local n = 0

end
