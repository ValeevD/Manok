GUIManager = Class{}

function GUIManager:init()
    self.guiList = {}
end

function GUIManager:Push(newGUI)
    table.insert(self.guiList, newGUI)
end

function GUIManager:Pop(guiToRemove)
    local ind = 0
    for i = 1, #self.guiList do
        if self.guiList[i] == guiToRemove then
            --table.remove(self.guiList, i)
            ind = i
            break
        end
    end
    if ind > 0 then
        table.remove(self.guiList, ind)
    end
end

function GUIManager:NewGUI()
    -- local _ng = GUI:load()
    -- self:Push(_ng)
    -- return _ng
    return GUI:load()
end

function GUIManager:mousepressed(...)
    for _,v in ipairs(self.guiList) do
        v:mousepress(...)
    end
end

function GUIManager:keypressed(key)
    for _,v in ipairs(self.guiList) do
        v:keypress(key)
    end
end

function GUIManager:textinput(key)
    for _,v in ipairs(self.guiList) do
        v:textinput(key)
    end
end
