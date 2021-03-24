DummyInputAction = {}

function DummyInputAction:init(activeFunc, triggeredFunc, vector2ValueFunc)

end

function DummyInputAction:Active()
    return false
end

function DummyInputAction:Triggered()
    return false
end

function DummyInputAction:Vector2Value()
    return Vector(0, 0)
end
