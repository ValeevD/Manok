Notification = Class({__includes = {ITweener}})

function Notification:init(coords, isLocal, GUILayer)
    ITweener.init(self)

    if not GUILayer then
        self.isDead = true
        return
    end

    self.GUILayer = GUILayer
    self.x, self.y = 0, 0

    self.isLocal = isLocal

    if coords then
        if self.isLocal then
            local currentCamera = cameraManager.currentCamera
            local currentPlayer = sceneManager.currentScene.player

            self.x, self.y = currentPlayer.x - currentCamera.x + love.graphics.getWidth()/2, currentPlayer.y - currentCamera.y + love.graphics.getHeight()/2
        end
    end

    self.element = self.GUILayer:text("Add Exp", {self.x, self.y, 128, Gspot.style.unit})
    self.element.style.labelfg = {0,0,0,1}
    self.element.update = function(this, dt)
        this.pos.x = self.x
        this.pos.y = self.y
    end

    local endY = self.y - 100
    self.timer:tween(1, self, {y = endY}, "linear", function ()
        self.isDead = true
        GUILayer:rem(self.element)
     end)

end

function Notification:update(dt)
    self.timer:update(dt)
end

function Notification:draw()
end
