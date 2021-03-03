UIManager = Class{}

function UIManager:init()
    self.canvasList = {}
end

function UIManager:Push(newCanvas)
    table.insert(self.canvasList, newCanvas)
end

function UIManager:Pop(canvas)
    if canvas == nil then
        canvas = self.canvasList[#self.canvasList]
    end

    for i = 1, #self.canvasList do
        if self.canvasList[i] == canvas then
            table.remove(self.canvasList, i)
            break
        end
    end
end

function UIManager:draw()
    for _,v in ipairs(self.canvasList) do v:draw() end
end
