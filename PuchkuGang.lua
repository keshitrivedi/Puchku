PuchkuGang = Class{}

function PuchkuGang:init()
    self.puchkus = {}
end

function PuchkuGang:update()
end

function PuchkuGang:render()
end

function PuchkuGang:getCount()
    local count = 0
    for _ in pairs(self.puchkus) do
        count = count + 1
    end
    return count
end
