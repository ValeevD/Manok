Camera = Class()

function Camera:init(gameObject, follow)
    self:SetGameobject(gameObject, follow)
    self.libCamera = HumpCamera()
end

function Camera:Attach()
    self.libCamera:attach()
end

function Camera:Detach()
    self.libCamera:detach()
end

function Camera:update(dt)
    if self.follow then
        self.libCamera:lookAt(self.gameObject.x, self.gameObject.y)
        self.x, self.y = self.gameObject.x, self.gameObject.y
    end
end

function Camera:SetGameobject(newGameObject, follow)
    self.gameObject = newGameObject
    self.x, self.y = 0, 0

    if self.gameObject then
        self.x, self.y = self.gameObject.x, self.gameObject.y
        self.follow = follow or false
        self.libCamera:lookAt(self.x, self.y)
    end
end
