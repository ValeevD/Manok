UIManager = Class{
    canvasList = {}
}

function UIManager:Push(newCanvas)
    table.insert(self.canvasList, newCanvas)
end

function UIManager:Pop(canvas)
    for i = 1, #self.canvasList do
        if self.canvasList[i] == canvas then
            table.remove(self.canvasList, i)
            break
        end
    end
end

function UIManager:NewCanvas()
    return UI:load()
end

function UIManager:update(dt)
    for _,v in ipairs(self.canvasList) do
        v:update(dt)
    end
end

function UIManager:draw()
    for _,v in ipairs(self.canvasList) do
        v:draw()
    end
end

function UIManager:mousepressed(...)
    for _,v in ipairs(self.canvasList) do
        v:mousepress(...)
    end
end

function UIManager:keypressed(key)
    for _,v in ipairs(self.canvasList) do
        v:keypress(key)
    end
end

function UIManager:textinput(key)
    for _,v in ipairs(self.canvasList) do
        v:textinput(key)
    end
end
