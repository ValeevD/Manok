--LIBS
Class  = require("lib/hump/class")
Timer  = require("lib/hump/timer")
Signal = require("lib/hump/signal")
GameState  = require("lib/hump/gamestate")
Input  = require("lib/input")
GUI    = require("lib/gspot/Gspot")


--OBJECTS
require("Foundation/Managers/SceneManager/SceneManager")
require("Foundation/Managers/Observer/IObserver")
require("Foundation/Managers/SceneManager/Interfaces/IOnSceneEnd")
require("Foundation/Managers/SceneManager/Interfaces/IOnSceneBegin")
require("Foundation/Managers/SceneStateManager/SceneStateManager")
require("Foundation/Managers/GUIManager/GUIManager")
require("Foundation/Scene/IScene")
require("Foundation/Scene/Scene")


require("Game/FadingScreen")
require("Game/Scene/SimpleScene")
require("Game/Scene/PictureScene")
