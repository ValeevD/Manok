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
    if state == nil then
        state = self.states[#self.states]
    end

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

            for k,v in pairs(state.onUpdate) do
                v(dt)
            end
        else
            for k,v in pairs(state.onUpdateDuringPause) do
                v(dt)
            end
        end

        doUpdate = doUpdate and state.updateParentState
    end
end

function SceneStateManager:updateFunc(funcName, ...)
    self:UpdateCachedGameStates()

    local doUpdate = true
    for i = #self.statesCache, 1, -1 do
        local state = self.statesCache[i]

        if doUpdate then

            for k,v in pairs(state.onUpdate) do
                if k[funcName] then k[funcName](k, ...) end
            end
        else
            for k,v in pairs(state.onUpdateDuringPause) do
                if k[funcName] then k[funcName](k, ...) end
            end
        end

        doUpdate = doUpdate and state.updateParentState
    end
end

function SceneStateManager:draw()
    -- self:UpdateCachedGameStates()

    -- local doUpdate = true
    -- for i = #self.statesCache, 1, -1 do
    --     local state = self.statesCache[i]

    --     if doUpdate then

    --         for k,v in pairs(state.onUpdate) do
    --             if k.draw then k:draw() end
    --         end
    --     else
    --         for k,v in pairs(state.onUpdateDuringPause) do
    --             if k.draw then k:draw() end
    --         end
    --     end

    --     doUpdate = doUpdate and state.updateParentState
    -- end

    self:updateFunc("draw")
end

function SceneStateManager:mousepressed(...)
    -- self:UpdateCachedGameStates()

    -- local doUpdate = true
    -- for i = #self.statesCache, 1, -1 do
    --     local state = self.statesCache[i]

    --     if doUpdate then

    --         for k,v in pairs(state.onUpdate) do
    --             if k.mousepress then k:mousepress(...) end
    --         end
    --     else
    --         for k,v in pairs(state.onUpdateDuringPause) do
    --             if k.mousepress then k:mousepress(...) end
    --         end
    --     end

    --     doUpdate = doUpdate and state.updateParentState
    -- end

    self:updateFunc("mousepress", ...)
end

function SceneStateManager:mousereleased(...)
    -- self:UpdateCachedGameStates()

    -- local doUpdate = true
    -- for i = #self.statesCache, 1, -1 do
    --     local state = self.statesCache[i]

    --     if doUpdate then

    --         for k,v in pairs(state.onUpdate) do
    --             if k.mouserelease then k:mouserelease(...) end
    --         end
    --     else
    --         for k,v in pairs(state.onUpdateDuringPause) do
    --             if k.mouserelease then k:mouserelease(...) end
    --         end
    --     end

    --     doUpdate = doUpdate and state.updateParentState
    -- end
    self:updateFunc("mouserelease", ...)
end

function SceneStateManager:keypressed(...)
    -- self:UpdateCachedGameStates()

    -- local doUpdate = true
    -- for i = #self.statesCache, 1, -1 do
    --     local state = self.statesCache[i]

    --     if doUpdate then

    --         for k,v in pairs(state.onUpdate) do
    --             if k.keypress then k:keypress(...) end
    --         end
    --     else
    --         for k,v in pairs(state.onUpdateDuringPause) do
    --             if k.keypress then k:keypress(...) end
    --         end
    --     end

    --     doUpdate = doUpdate and state.updateParentState
    -- end

    self:updateFunc("keypress", ...)
end

function SceneStateManager:textinput(...)
    -- self:UpdateCachedGameStates()

    -- local doUpdate = true
    -- for i = #self.statesCache, 1, -1 do
    --     local state = self.statesCache[i]

    --     if doUpdate then

    --         for k,v in pairs(state.onUpdate) do
    --             if k.textinput then k:textinput(...) end
    --         end
    --     else
    --         for k,v in pairs(state.onUpdateDuringPause) do
    --             if k.textinput then k:textinput(...) end
    --         end
    --     end

    --     doUpdate = doUpdate and state.updateParentState
    -- end

    self:updateFunc("textinput", ...)
end
