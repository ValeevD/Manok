--LIBS
Class     = require("lib/hump/class")
Timer     = require("lib/hump/timer")
Signal    = require("lib/hump/signal")
GameState = require("lib/hump/gamestate")
Input     = require("lib/input")
Gspot     = require("lib/gspot/Gspot")

--OBJECTS
require("Foundation/Managers/SceneManager/SceneManager")
require("Foundation/Managers/Observer/IObserver")
require("Foundation/Managers/SceneManager/Interfaces/IOnSceneEnd")
require("Foundation/Managers/SceneManager/Interfaces/IOnSceneBegin")
require("Foundation/Managers/UIManager/UIManager")
require("Foundation/Managers/UIManager/GUI")
require("Foundation/Scene/Scene")
require("Foundation/Managers/SceneStateManager/SceneState/SceneState")
require("Foundation/Managers/SceneStateManager/SceneStateManager")

Class.include(Gspot, IObserver)

require("Game/FadingScreen")
require("Game/Scene/PictureScene")

clickSource = love.audio.newSource("resources/click.wav", "static")
fadeInSource = love.audio.newSource("resources/fade_in.wav", "static")
fadeOutSource = love.audio.newSource("resources/fade_out.wav", "static")
