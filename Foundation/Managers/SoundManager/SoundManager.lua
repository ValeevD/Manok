SoundManager = Class{__includes = {IObserver}}

function SoundManager:init()
    --self.sceneManager = sceneManager

    self.musicFadeTime = 1
    self.channels = {}

    self.listener = nil

    self.sfxChannel = self:AddChannel("sfx")
    self.sfxChannel:SetEnabled(true)
    self.sfxChannel:SetVolume(0)

    self.musicChannel = self:AddChannel("music")
    self.musicChannel:SetEnabled(true)
    self.musicChannel:SetVolume(0)

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
        qqq = qqq + 1
        if self.currentMusic.clip == clip then
            self.currentMusic:SetVolume(volume)
            return
        end

        self.currentMusic:FadeToStop(self.musicFadeTime)
    end

    self.currentMusic = self.musicChannel:Play(clip, true, true, 0)
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
