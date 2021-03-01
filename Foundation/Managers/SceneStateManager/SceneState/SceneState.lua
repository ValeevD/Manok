SceneState = Class{}

function SceneState:init()
    self.isTopmost = false
    self.isVisible = false
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

function SceneState:BecomeTopmost()
    if self.isTopmost then
        return
    end

    self.isTopmost = true
    for _,v in ipairs(self.onBecomeTopmost) then v() end
end

function SceneState:ResignTopmost()
    if not self.isTopmost then
        return
    end

    self.isTopmost = false
    for _,v in ipairs(self.onResignTopmost) then v() end
end
