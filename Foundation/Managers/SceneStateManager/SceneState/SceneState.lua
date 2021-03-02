SceneState = Class{}

function SceneState:init()
    self.isTopmost = false
    self.isVisible = false
    self.updateParentState = false
    self.sortingOrder = 0

    self.onActivate = {}
    self.onDeactivate = {}

    self.onUpdate = {}
    self.onUpdateDuringPause = {}

    self.onBecomeTopmost = {}
    self.onResignTopmost = {}

    self.onSortingOrderChanged = {}
end

function SceneState:Activate()
    if self.isVisible then
        return
    end

    self.isVisible = true
    for _,v in ipairs(self.onActivate) do v() end
end

function SceneState:Deactivate()
    if not self.isVisible then
        return
    end

    self.isVisible = false
    for _,v in ipairs(self.onDeactivate) do v() end
end

function SceneState:BecomeTopmost()
    if self.isTopmost then
        return
    end

    self.isTopmost = true
    for _,v in ipairs(self.onBecomeTopmost) do v() end
end

function SceneState:ResignTopmost()
    if not self.isTopmost then
        return
    end

    self.isTopmost = false
    for _,v in ipairs(self.onResignTopmost) do v() end
end

function SceneState:SetSortingOrder(sortingOrder)
    self.sortingOrder = sortingOrder

    for _,v in ipairs(self.onSortingOrderChanged) do v() end
end
