PlayerLookCameraInput = Class{__includes = {IObserver}}

function PlayerLookCameraInput:init(player, sceneState)
    IObserver.init(self)
    self.player = player
    self.sceneState = sceneState

    self:Observe(sceneState.onUpdate, function(dt)
        local input = inputManager:InputForPlayer(self.player.playerIndex)
        local pressed = input:Action("CameraLook"):Triggered()

        if pressed then
            local currentGameObject = cameraManager.currentCamera.gameObject

            if self.player == currentGameObject then
                cameraManager.currentCamera:SetGameobject({x = self.player.x, y = self.player.y})
            else
                cameraManager.currentCamera:SetGameobject(self.player, true)
            end
        end
    end)
end
