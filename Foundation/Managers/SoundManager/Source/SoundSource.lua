SoundSource = Class{__includes = {ITweener}}

function SoundSource:init(clip)
    self.clip = clip
    self.handleID = HandleID + 1
    self.volume = clip and clip:getVolume() or 0
    self.volumeChanged = true

    self.loop = false
    self.soundChannel = nil
    self.ignoreListenerPause = false
    self.surviveOnSceneLoad = false
    self.target = nil

    HandleID = HandleID + 1

    ITweener.init(self)
end

function SoundSource:Dispose()
    self.handleID = -1
    self:Kill()

    if self.clip and self.clip:isPlaying() then
        self.clip:stop()
    end
end

function SoundSource:Kill()
    ITweener.Kill(self)
end

function SoundSource:Fade(endValue, time)
    self.volume = clip and clip:getVolume() or 0
    self.volumeChanged = true
    self.timer:tween(time, self, {volume = endValue}, "linear", function() self.volumeChanged = false end)
end

function SoundSource:update(dt)
    if self.volumeChanged and self.clip then
        self.clip:setVolume(self.volume * self.soundChannel.volume)
    end

    self.timer:update(dt)
end

function SoundSource:SetTarget(target)
    if not target or not target.x or not target.y then
        self.target = nil
    end

    self.target = target
end

function SoundSource:SoundChannel(channel)
    self.soundChannel = channel
end

function SoundSource:SetVolume(newVol)
    self.volume = newVol

    self:RefreshVolume()
end

function SoundSource:RefreshVolume()
    if self.clip then
        self.clip:setVolume(self.volume * self.soundChannel.volume)
    end
end

function SoundSource:Play()
    if not self.clip then
        return
    end

    self.clip:setLooping(self.loop)
    self.clip:setVolume(self.volume * self.soundChannel.volume)

    if self.target then
        self.clip:setPosition(self.target.x, self.target.y)
        self.clip:setRelative(false)
    end

    self.clip:play()
end
