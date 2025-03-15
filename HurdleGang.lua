HurdleGang = Class{}

function HurdleGang:init()
    self.hurdles = {}
    
    self:generateHurdles()
end

function HurdleGang:generateHurdles()
    self.hurdles = {}

    for i = 1, gLevel do
        local newHurdle
        local isValid

        repeat
            isValid = true
            newHurdle = Hurdle()

            for _, hurdle in ipairs(self.hurdles) do
                if math.abs(newHurdle.x - hurdle.x) < 40 + newHurdle.width and
                   math.abs(newHurdle.y - hurdle.y) < 40 + newHurdle.height then
                    isValid = false
                    break
                end
            end
        until isValid

        table.insert(self.hurdles, newHurdle)
    end
end

    
function HurdleGang:render()
    for _, hurdle in ipairs(self.hurdles) do
        hurdle:render()
    end
end