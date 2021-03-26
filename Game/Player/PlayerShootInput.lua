PlayerShootInput = Class{__includes = {IObserver}}

function PlayerShootInput:init(player, sceneState)
    IObserver.init(self)
    self.player = player
    self.sceneState = sceneState

    self:Observe(sceneState.onUpdate, function(dt)
        local input = inputManager:InputForPlayer(self.player.playerIndex)
        local pressed = input:Action("Shoot"):Triggered()

        if pressed then
            table.insert(sceneManager.currentScene.gameObjects, Bullet(self.player.x + 32, self.player.y + 32, self.player.direction:normalized()))
            soundManager.sfxChannel:Play(ShootSource:clone(), false, false, 0.1)
        end
    end)
end
