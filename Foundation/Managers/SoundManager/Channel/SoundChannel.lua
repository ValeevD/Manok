SoundChannel = Class()

function SoundChannel:init()
    self.channelID = ""

    self.soundSources = {}
    self.volumeChanged = false
    self.enabled = false
    self.volume = 1
end

function SoundChannel:SetEnabled(value)
    if self.enabled == value then
        return
    end

    self.enabled = value
    self.volumeChanged = true
end

function SoundChannel:SetVolume(value)
    if math.abs(self.volume - value) < 0.01 then
        return
    end

    self.volume = value
    self.volumeChanged = true
end

function SoundChannel:Play(clip, loop, surviveSceneLoad, volume)
    return self:PlayAt(nil, clip, loop, surviveSceneLoad, volume)
end

function SoundChannel:PlayAt(gameObject, clip, loop, surviveSceneLoad, volume)
    if not gameObject or not gameObject.x or not gameObject.y then
        self:Play(clip, loop, surviveSceneLoad, volume)
    end
end
