SoundManager = Class{__includes = {IObserver}}

function SoundManager:init(sceneManager)
    self.sceneManager = sceneManager

    self.musicFadeTime = 1
    self.channels = {}

    self.listener = nil

    self.currentMusic = SoundHandle()
    self.sfxChannel = nil
    self.musicChannel = nil
end

function SoundManager:AddChannel(channelName)
    self.channels[channelName] = SoundChannel()
end

function SoundManager:GetChannel(channelName)
    return self.channels[channelName]
end

function SoundManager:PlayMusic(clip, volume)
    if self.currentMusic.isPlaying then
        if self.currentMusic.audioClip == clip then
            self.currentMusic.volume = volume
            return
        end

        self.currentMusic:FadeToStop(self.musicFadeTime)
    end

    self.currentMusic = self.musicChannel:Play(clip, true, true, 0)
    self.currentMusic:Fade(1, self.musicFadeTime)
end

function SoundManager:StopMusic()
    if self.currentMusic.isPlaying then
        self.currentMusic:FadeToStop(self.musicFadeTime)
    end

    self.currentMusic = SoundHandle()
end

function SoundManager:OnEnable()
    self:Observe(self.sceneManager.onCurrentSceneUnload, function()
        for _,channel in pairs(self.channels) do
            channel:StopAllSounds(false)
        end
    end)
end

function SoundManager:update(dt)
    for _,channel in pairs(self.channels) do
        channel:Update(dt)
    end
end
