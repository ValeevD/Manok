InputHandler = Class{}

function InputHandler:init()
    self.target = nil
    self.targetQueue = {}
end

function InputHandler:PushControlPoint(controlPoint)
    self.target = controlPoint
    table.insert(self.targetQueue, controlPoint)
end

function InputHandler:PopControlPoint(controlPoint)
    table.remove(self.targetQueue, #self.targetQueue)

    self.target = self.targetQueue[#self.targetQueue]
end

function InputHandler:IterateTarget()
    for i = 1, #self.targetQueue do
        if self.target == self.targetQueue[i] then
            self.target = self.targetQueue[(i == #self.targetQueue) and 1 or (i + 1)]
            break
        end
    end
end

function InputHandler:update(dt, inputs)
    if inputs.up then
        self.target:up(dt)
    end

    if inputs.down then
        self.target:down(dt)
    end

    if inputs.left then
        self.target:left(dt)
    end

    if inputs.right then
        self.target:right(dt)
    end

    if inputs.space then
        self:IterateTarget()
    end
end
