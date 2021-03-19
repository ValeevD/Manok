--LIBS
Class     = require("lib/hump/class")
Timer     = require("lib/hump/timer")
Signal    = require("lib/hump/signal")
GameState = require("lib/hump/gamestate")
Input     = require("lib/input")
Gspot     = require("lib/gspot/Gspot")

HandleID  = 0


cartographer = require("lib/cartographer")
require("Foundation/Observer/IObserver")

--OBJECTS
require("Foundation/Managers/SceneManager/SceneManager")

--SOUND MANAGER
require("Foundation/Managers/SoundManager/Source/SoundSource")
require("Foundation/Managers/SoundManager/Source/SoundHandle")

require("Foundation/Managers/SoundManager/Channel/SoundChannel")

require("Foundation/Managers/SoundManager/SoundManager")

require("Foundation/Managers/Interfaces/ITweener")
require("Foundation/Managers/Interfaces/IOnSceneEnd")
require("Foundation/Managers/Interfaces/IOnSceneBegin")
require("Foundation/Managers/UIManager/UIManager")
require("Foundation/Managers/UIManager/GUI")
require("Foundation/Scene/Scene")
require("Foundation/Managers/SceneStateManager/SceneState/SceneState")
require("Foundation/Managers/SceneStateManager/SceneStateManager")

Class.include(Gspot, IObserver)

require("Game/FadingScreen")
require("Game/Scene/PictureScene")

clickSource = love.audio.newSource("resources/click.mp3", "static")
backGroundSource1 = love.audio.newSource("resources/Background_1.mp3", "stream")
backGroundSource2 = love.audio.newSource("resources/Background_2.mp3", "stream")
fadeInSource = love.audio.newSource("resources/fade_in.wav", "static")
fadeOutSource = love.audio.newSource("resources/fade_out.mp3", "static")
