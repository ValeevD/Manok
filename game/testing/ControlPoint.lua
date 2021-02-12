ControlPoint = Class{}

function ControlPoint:init(controlObject)
    self.controlObject = controlObject
end

function ControlPoint:bind(controlObject)
    self.controlObject = controlObject
end

function ControlPoint:up(dt)
end

function ControlPoint:down(dt)
end

function ControlPoint:left(dt)
end

function ControlPoint:right(dt)
end

function ControlPoint:space(dt)
end
