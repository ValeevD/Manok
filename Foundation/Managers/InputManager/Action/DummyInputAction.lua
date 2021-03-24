InputAction = {}

function InputAction:init(activeFunc, triggeredFunc, vector2ValueFunc)

end

function InputAction:Active()
    return false
end

function InputAction:Triggered()
    return false
end

function InputAction:Vector2Value()
    return Vector(0, 0)
end
