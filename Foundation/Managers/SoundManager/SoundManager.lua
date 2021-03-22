SoundManager = Class{__includes = {IObserver}}

function SoundManager:init()
    self.musicFadeTime = 1
    self.channels = {}

    self.listener = nil

    self.sfxChannel = self:AddChannel("sfx")
    self.sfxChannel:SetEnabled(true)

    self.musicChannel = self:AddChannel("music")
    self.musicChannel:SetEnabled(true)

    self.currentMusic = nil
end

function SoundManager:AddChannel(channelName)
    local newChannel = SoundChannel(channelName)
    self.channels[channelName] = newChannel
    return newChannel
end

function SoundManager:GetChannel(channelName)
    return self.channels[channelName]
end

function SoundManager:PlayMusic(clip, volume)
    --volume = volume or 1
    if self.currentMusic and self.currentMusic:IsPlaying() then
        if self.currentMusic.clip == clip then
            self.currentMusic:SetVolume(volume)
            return
        end

        self.currentMusic:FadeToStop(self.musicFadeTime)
    end

    self.currentMusic = self.musicChannel:Play(clip, true, false, 0)
    self.currentMusic:Fade(volume, self.musicFadeTime)
end

function SoundManager:StopMusic()
    if self.currentMusic.isPlaying then
        self.currentMusic:FadeToStop(self.musicFadeTime)
    end

    self.currentMusic = SoundHandle()
end

function SoundManager:OnEnable()
    self:Observe(sceneManager.onCurrentSceneUnload, function()
        for _,channel in pairs(self.channels) do
            channel:StopAllSounds(false)
        end
    end)
end

function SoundManager:update(dt)
    for _,channel in pairs(self.channels) do
        channel:update(dt)
    end
end
