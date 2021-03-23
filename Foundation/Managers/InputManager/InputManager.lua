InputManager = Class()

function InputManager:init()
    self.inputSources = {}
    self.inputSourcesOverrides = {}
end

function InputManager:InputForPlayer(playerIndex)
    local inputSource = self.inputSourcesOverrides[playerIndex]
    if inputSource then
        return inputSource
    end

    inputSource = self.inputSources[playerIndex]
    if inputSource then
        return inputSource
    end
end

function InputManager:InputOverridenForPlayer(playerIndex)
    return self.inputSourcesOverrides ~= nil
end

function InputManager:OverrideInputForPlayer(playerIndex, overrideSource)
    if overrideSource == nil then
        self.inputSourcesOverrides[playerIndex] = nil
        return
    end

    self.inputSourcesOverrides[playerIndex] = overrideSource
end
