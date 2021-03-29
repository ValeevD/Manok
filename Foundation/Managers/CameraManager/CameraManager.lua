CameraManager = Class()

function CameraManager:init()
    self.allPoints = {}
    self.currentCamera = nil
end

function CameraManager:AddCamera(gameObject, follow)
    if self.currentCamera == nil then
        self.currentCamera = Camera()
    end

    self:SetCameraGameObject(gameObject, follow)
end

function CameraManager:RemovePoint(gameObject)
    for i = 1, #self.allPoints do
        if gameObject == self.allPoints[i] then
            table.remove(self.allPoints, i)
            return
        end
    end
end

function CameraManager:SetCameraGameObject(gameObject, follow)
    self.currentCamera:SetGameobject(gameObject, follow)

    for k,v in ipairs(self.allPoints) do
        if v == gameObject then return end
    end

    table.insert(self.allPoints, gameObject)
end

function CameraManager:BeforeUpdate()
    if self.currentCamera then self.currentCamera:Attach() end
end

function CameraManager:update(dt)
    if self.currentCamera then
        self.currentCamera:update(dt)
    end
end

function CameraManager:AfterUpdate()
    if self.currentCamera then self.currentCamera:Detach() end
end
