NotificationManager = Class()

function NotificationManager:init()
end

function NotificationManager:ShowMessage(GUILayer)
    local currentScene = sceneManager.currentScene

    table.insert(currentScene.gameObjects, Notification({x = currentScene.player.x, y = currentScene.player.y}, true, GUILayer))
end
