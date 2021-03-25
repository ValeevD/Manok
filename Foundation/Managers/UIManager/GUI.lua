NewGUI = function(sceneState)
    local newGspot = Gspot()

    newGspot.blockMouseClick = false
    newGspot.sceneState = sceneState

    IObserver.init(newGspot)

    newGspot.update = function(self, ...)
        self.blockMouseClick = self.mousein or self.drag
        sceneManager.currentScene.stateManager.currentState.blockByUI = self.mousein or self.drag

        Gspot.update(self, ...)
    end

    return newGspot
end
