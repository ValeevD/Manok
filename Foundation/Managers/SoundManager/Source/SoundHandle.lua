SoundHandle = Class{}

function SoundHandle:init(soundChannel, soundSource)
    self.soundChannel = soundChannel or nil
    self.soundSource = soundSource or nil
    self.handleID = soundSource.handleID
    self.timer = Timer()
end

function SoundHandle:IsValid()
    return self.soundSource and self.soundSource.handleID == self.handleID
end

function SoundHandle:IsPlaying()
    return self:IsValid() and self.soundSource.clip:isPlaying()
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
    self.soundSource:SetVolume(value)
end

function SoundHandle:Stop()
    self.soundChannel:Stop(self)
end

function SoundHandle:Fade(endValue, time)
    self.soundSource:Fade(endValue, time)
end

function SoundHandle:FadeToStop(time)
    self.timer:after(time, function() self:Dispose() end)
    self.soundSource:Kill()
    self:Fade(0, time)
end

function SoundHandle:update(dt)
    if self.soundSource then
        self.soundSource:update(dt)
    end
end

function SoundHandle:Dispose()
    self.soundSource:Dispose()
    self.timer = nil
end
