IObserver = Class{}

function IObserver:init()
    self.observerLists = {}
end

function IObserver:Observe(observerList, func)
    table.insert(self.observerLists, observerList)

    observerList[self] = func

    return self
end

function IObserver:OnDisable()
    for _,v in ipairs(self.observerLists) do
        v[self] = nil
    end
end
