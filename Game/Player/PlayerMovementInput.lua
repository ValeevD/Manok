PlayerMovementInput = Class{__includes = {IObserver}}

function PlayerMovementInput:init(player, sceneState)
    IObserver.init(self)

    self.speed = 0
    self.acceleration = 200
    self.maxSpeed = 100

    self.player = player
    self.sceneState = sceneState

    self:Observe(sceneState.onUpdate, function(dt)
        local input = inputManager:InputForPlayer(self.player.playerIndex)
        local dir = input:Action("Move"):Vector2Value()

        if dir ~= Vector(0, 0) then
            self.player.speed = math.min(self.player.maxSpeed, self.player.speed + self.player.acceleration * dt)
            self.player.direction = dir
        else
            self.player.speed = 0
        end

        local speedVector = dir:normalized() * self.player.speed

        self.player.x = self.player.x + speedVector.x * dt
        self.player.y = self.player.y - speedVector.y * dt
    end)
end
