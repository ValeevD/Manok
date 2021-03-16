ITweener = Class{}

function ITweener:init()
    self.timer = Timer()
end

function ITweener:Kill()
    local handlers = self.timer.functions

    for k,v in pairs(handlers) do
        handlers[k] = nil
    end
end
