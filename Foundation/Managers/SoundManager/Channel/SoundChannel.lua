SoundChannel = Class()

function SoundChannel:init(channelName, mixer)
    self.channelName = channelName

    self.mixer = mixer

    self.enabled = false--load from settings
    self.volume = 1     --load from settings
    self.volumeChanged = true

    self.soundSources = {}
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
    local target = gameObject
    if not gameObject or not gameObject.x or not gameObject.y then
        target = nil
    end

    local soundSource = soundSourceFactory.create(clip)

    soundSource.volume = volume
    soundSource.loop = loop
    soundSource.soundChannel = self
    soundSource.ignoreListenerPause = surviveSceneLoad
    soundSource.surviveOnSceneLoad = surviveSceneLoad
    soundSource.target = target

    table.insert(self.soundSources, soundSource)

    if clip and (self.enabled or loop) then
        soundSource.clip = clip
        soundSource:play()
    end

    return SoundHandle(self, soundSource)
end

function SoundChannel:Stop(handle)
    if not (handle and handle.isValid) then
        return
    end

    for ind, vlaue in self.soundSources do
        if vlaue == handle.source then
            table.remove(self.soundSources, ind)
            handle.source:Dispose()
            return
        end
    end
end

function SoundChannel:StopAllSounds(includingSurviveSceneLoad)
    for i = #self.soundSources, 1, -1 do
        local source = self.soundSources[i]

        if includingSurviveSceneLoad or not source.surviveOnSceneLoad then
            table.remove(self.soundSources, i)
            source:Dispose()
        end
    end
end

function SoundChannel:update(dt, listener)
    for i = #self.soundSources, 1, -1 do
        local source = self.soundSources[i]

        if not source then
            table.remove(self.soundSources, i)
        elseif not source.isPlaying then
            table.remove(self.soundSources, i)
            source:Dispose()
        elseif not self.enabledand not source.loop then
            table.remove(self.soundSources, i)
            source:Dispose()
        else
            local sourceGameObject = source.target

            if not sourceGameObject then
                sourceGameObject = listener
            end

            source.target = sourceGameObject
        end
    end
end
