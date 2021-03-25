PlayerLookInput = Class{__includes = {IObserver}}

function PlayerLookInput:init(player, sceneState)
    IObserver.init(self)
    self.player = player
    self.sceneState = sceneState

    self:Observe(sceneState.onUpdate, function(dt)
        local input = inputManager:InputForPlayer(self.player.playerIndex)
        local vect = input:Action("Look"):Vector2Value()
        local wid, hei = love.graphics.getWidth()/2, love.graphics.getHeight()/2

        local ax, ay = vect.x - love.graphics.getWidth()/2 - 32, vect.y - love.graphics.getHeight()/2 - 32

        if vect ~= Vector(0,0) then
            self.player.look.x = math.abs(ax) < 10 and 0 or ax / math.abs(ax)
            self.player.look.y = math.abs(ay) < 10 and 0 or -ay / math.abs(ay)
        end
    end)
end
