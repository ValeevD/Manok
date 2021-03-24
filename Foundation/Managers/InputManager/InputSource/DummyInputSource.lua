DummyInputSource = {}

function DummyInputSource:Dispose()
end

function DummyInputSource:DisconnectAllActions()
end

function DummyInputSource:Action(name)
    return DummyInputAction
end
