UIManager = Class{}

function UIManager:init()
    self.canvasList = {}
end

function UIManager:Push(newCanvas)
    table.insert(self.canvasList, newCanvas)
end

function UIManager:Pop(canvas)
    for i = 1, #self.canvasList do
        if self.canvasList[i] == canvas then
            self.canvasList[i] = self.canvasList[#self.canvasList]
            table.remove(self.canvasList, #self.canvasList)
            break
        end
    end
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
    -- for _,v in ipairs(self.canvasList) do
    --     v:mousepress(...)
    -- end

    if #self.canvasList > 0 then
        self.canvasList[#self.canvasList]:mousepress(...)
    end
end

function UIManager:keypressed(...)
    for _,v in ipairs(self.canvasList) do
        v:keypress(...)
    end
end

function UIManager:textinput(...)
    for _,v in ipairs(self.canvasList) do
        v:textinput(...)
    end
end
