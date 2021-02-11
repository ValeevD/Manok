InputManager = Class{}

function InputManager:init()
    self.target = nil
    self.targetQueue = {}

    self:initializeInput()
end

function InputManager:RegisterControlPoint(controlPoint)
    self.target = controlPoint
    self.targetQueue = {}
end

function InputManager:PushControlPoint(controlPoint)
    self.target = controlPoint
    self.targetQueue[#self.targetQueue + 1] = controlPoint
end

function InputManager:PopControlPoint(controlPoint)
    table.remove(self.targetQueue, #self.targetQueue)

    self.target = self.targetQueue[#self.targetQueue]
    --self.targetQueue[#self.targetQueue + 1] = controlPoint
end

function InputManager:initializeInput()
    input = Input()

    input:bind("w", "up")
    input:bind("s", "down")
    input:bind("a", "left")
    input:bind("d", "right")
    input:bind("space", "space")

end

function InputManager:update(dt)
    if input:down("up") then
        self.target:up(dt)
    end
    if input:down("down") then
        self.target:down(dt)
    end
    if input:down("left") then
        self.target:left(dt)
    end
    if input:down("right") then
        self.target:right(dt)
    end
end
