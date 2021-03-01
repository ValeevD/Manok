IObserver = Class{}

function IObserver:init()
    self.observerLists = {}
end

function IObserver:Observe(observerList, func)
    table.insert(self.observerLists, observerList)

    observerList[self] = func
end
