IObserver = Class{
    observerLists = {}
}

function IObserver:Observe(observerList, func)
    table.insert(self.observerLists, observerList)

    observerList[self] = func
end
