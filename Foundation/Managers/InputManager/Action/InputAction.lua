InputAction = Class()

function InputAction:init(activeFunc, triggeredFunc, vector2ValueFunc)
    self.activeFunc = activeFunc
    self.triggeredFunc = triggeredFunc
    self.vector2ValueFunc = vector2ValueFunc
end

function InputAction:Active()
    return self.activeFunc and self.activeFunc()
end

function InputAction:Triggered()
    return self.triggeredFunc and self.triggeredFunc()
end

function InputAction:Vector2Value()
    return self.vector2ValueFunc and self.vector2ValueFunc()
end
