PlayerInput = Class()

function PlayerInput:init()
    self.vector = Vector()

    self.actions = {}
    self.actions["Move"] = InputAction(
        nil,
        nil,
        function()
            self.vector.x = (input:down("right") and 1 or 0) - (input:down("left") and 1 or 0)
            self.vector.y = (input:down("up") and 1 or 0) - (input:down("down") and 1 or 0)

            return self.vector
        end
    )

    self.actions["Shoot"] = InputAction(
        nil,
        function()
            return input:pressed("mouse1") and not sceneManager.currentScene.stateManager.currentState.blockByUI
        end,
        nil
    )

    self.actions["Look"] = InputAction(
        nil,
        nil,
        function()
            self.vector.x, self.vector.y = love.mouse.getPosition()
            return self.vector
        end
    )
end

function PlayerInput:FindAction(name)
    return self.actions[name]
end
