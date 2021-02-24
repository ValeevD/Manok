SimpleScene = Class{__includes = {Scene, IObserver, IOnSceneEnd, IOnSceneBegin}}

function SimpleScene:init(opts)
    self.opts = opts or {}

    self.color = self.opts.color or {1,1,1,1}
end
function SimpleScene:OnEnable()
    for _,v in ipairs(self.gameObjects) do
        if v.OnEnable then
            v:OnEnable()
        end
    end
end

function SimpleScene:OnDisable()
    for _,v in ipairs(self.gameObjects) do
        if v.OnDisable then
            v:OnDisable()
        end
    end
end

function SimpleScene:draw()
    local prevColor = {love.graphics.getColor()}
    love.graphics.setColor(unpack(self.color))
    love.graphics.rectangle("fill", 0, 0, 1000, 1000)
    love.graphics.setColor(unpack(prevColor))

    Scene.draw(self)
end
