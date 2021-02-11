SquareControlPoint = Class{__includes = {ControlPoint}}

function SquareControlPoint:up(dt)
    self.controlObject:moveUp(dt)
end

function SquareControlPoint:down(dt)
    self.controlObject:moveDown(dt)
end

function SquareControlPoint:left(dt)
    self.controlObject:moveLeft(dt)
end

function SquareControlPoint:right(dt)
    self.controlObject:moveRight(dt)
end
