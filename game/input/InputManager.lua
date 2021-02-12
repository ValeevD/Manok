InputManager = Class{}

function InputManager:init()
    self.target = nil
    self.targetQueue = {}

    self.inputs = {}

    self:InitializeInput()
end

function InputManager:PushHandler(controlPoint)
    self.target = controlPoint
    self.targetQueue[#self.targetQueue + 1] = controlPoint
end

function InputManager:PopHandler(controlPoint)
    table.remove(self.targetQueue, #self.targetQueue)

    self.target = self.targetQueue[#self.targetQueue]
end

function InputManager:InitializeInput()
    input = Input()

    input:bind("w", "up")
    input:bind("s", "down")
    input:bind("a", "left")
    input:bind("d", "right")
    input:bind("space", "space")
    input:bind("mouse1", "mouse1")
    input:bind("mouse2", "mouse2")
end

function InputManager:update(dt)
    if self.target then
        self:UpdateInputState()
        self.target:update(dt, self.inputs)
    end
end

function InputManager:UpdateInputState()
    self.inputs.up    = input:down("up")
    self.inputs.down  = input:down("down")
    self.inputs.left  = input:down("left")
    self.inputs.right = input:down("right")
    self.inputs.space = input:pressed("space")
end
