SimpleScene = Class{__includes = {Scene, IObserver, IOnSceneEnd, IOnSceneBegin}}

function SimpleScene:init(opts)
    self.opts = opts or {}

    self.color = self.opts.color or {1,1,1,1}
end

function SimpleScene:draw()
    local prevColor = {love.graphics.getColor()}
    love.graphics.setColor(unpack(self.color))
    love.graphics.rectangle("fill", 0, 0, 1000, 1000)
    love.graphics.setColor(unpack(prevColor))

    Scene.draw(self)
end
