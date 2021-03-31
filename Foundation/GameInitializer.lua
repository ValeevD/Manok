--LIBS
Class = require("lib/hump/class")
Vector = require("lib/hump/vector")
Timer = require("lib/hump/timer")
Signal = require("lib/hump/signal")
GameState = require("lib/hump/gamestate")
Input = require("lib/input")
Gspot = require("lib/gspot/Gspot")
Anim8 = require("lib/anim8")

HumpCamera = require("lib/hump/camera")

HandleID  = 0

cartographer = require("lib/cartographer")
require("Foundation/Observer/IObserver")

require("Foundation/Managers/Interfaces/ITweener")
require("Foundation/Managers/Interfaces/IOnSceneEnd")
require("Foundation/Managers/Interfaces/IOnSceneBegin")

--OBJECTS
require("Foundation/Managers/SceneManager/SceneManager")

--NOTIFICATIONS
require("Foundation/Managers/NotificationManager/Notification")
require("Foundation/Managers/NotificationManager/NotificationManager")


--SOUND MANAGER
require("Foundation/Managers/SoundManager/Source/SoundSource")
require("Foundation/Managers/SoundManager/Source/SoundHandle")

require("Foundation/Managers/SoundManager/Channel/SoundChannel")

require("Foundation/Managers/SoundManager/SoundManager")

--INPUT MANAGER
require("Foundation/Managers/InputManager/Action/DummyInputAction")
require("Foundation/Managers/InputManager/Action/InputAction")

require("Foundation/Managers/InputManager/InputSource/InputSource")
require("Foundation/Managers/InputManager/InputSource/DummyInputSource")

require("Foundation/Managers/InputManager/InputManager")

--CAMERA MANAGER
require("Foundation/Managers/CameraManager/Camera")
require("Foundation/Managers/CameraManager/CameraManager")

require("Foundation/Managers/UIManager/UIManager")
require("Foundation/Managers/UIManager/GUI")
require("Foundation/Scene/Scene")
require("Foundation/Managers/SceneStateManager/SceneState/SceneState")
require("Foundation/Managers/SceneStateManager/SceneStateManager")

Class.include(Gspot, IObserver)

require("Game/Player/PlayerInput")

require("Game/Bullet")
require("Game/FadingScreen")
require("Game/Scene/PictureScene")

require("Game/Player/PlayerMovementInput")
require("Game/Player/PlayerShootInput")
require("Game/Player/PlayerLookInput")
require("Game/Player/PlayerLookCameraInput")
require("Game/Player/Player")

clickSource = love.audio.newSource("resources/click.mp3", "static")
backGroundSource1 = love.audio.newSource("resources/Background_1.mp3", "stream")
backGroundSource2 = love.audio.newSource("resources/Background_2.mp3", "stream")
fadeInSource = love.audio.newSource("resources/fade_in.wav", "static")
fadeOutSource = love.audio.newSource("resources/fade_out.mp3", "static")
ShootSource = love.audio.newSource("resources/Shoot.wav", "static")
