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

function SceneStateManager:UpdateCachedGameStates()
    if not self.stateListChanged then
        return
    end

    qqq = qqq + 1

    self.stateListChanged = false

    self.statesCache = {}

    if #self.states == 0 then
        if self.currentState then
            self.currentState:ResignTopmost()
            self.currentState = nil
        end
        return
    end

    for i = 1, #self.states do
        self.statesCache[i] = self.states[i]
        self.statesCache[i]:SetSortingOrder(i)
    end

    if self.currentState ~= self.statesCache[#self.statesCache] then
        local oldState = self.currentState
        self.currentState = self.statesCache[#self.statesCache]
        self.currentState:BecomeTopmost()
        if oldState then
            oldState:ResignTopmost()
        end
    end

end

function SceneStateManager:update(dt)
    self:UpdateCachedGameStates()

    local doUpdate = true
    for i = #self.statesCache, 1, -1 do
        local state = self.statesCache[i]

        if doUpdate then

            for _,v in pairs(state.onUpdate) do
                v(dt)
            end
        else
            for _,v in pairs(state.onUpdateDuringPause) do
                v(dt)
            end
        end

        doUpdate = doUpdate and state.updateParentState
    end
end
