SoundHandle = Class{}

function SoundHandle:init(soundChannel, soundSource)
    self.soundChannel = soundChannel or nil
    self.soundSource = soundSource or nil
    self.handleID = soundSource.handleID
end

function SoundHandle:IsValid()
    return self.soundSource and self.soundSource.handleID == self.handleID
end

function SoundHandle:IsPlaying()
    return self:IsValid() and self.soundSource.source:isPlaying()
end

function SoundHandle:IsLooping()
    self.soundSource.clip:isLooping()
end

function SoundHandle:SetLooping(value)
    self.soundSource.clip:setLooping(value)
end

function SoundHandle:GetVolume()
    self.soundSource.clip:getVolume()
end

function SoundHandle:SetVolume(value)
    self.soundSource.clip:setVolume(value)
end

function SoundHandle:Stop()
    self.soundChannel:Stop(self)
end

function SoundHandle:Fade(endValue, time)
    soundSource:Fade(endValue, time)
end

function SoundHandle:FadeToStop(time)
    self.soundSource:Kill()
    self:Fade(0, time)
end
