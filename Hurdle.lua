Hurdle = Class{}

function Hurdle:init()
    self.x = math.random(30, VIRTUAL_WIDTH-35)
    self.y = math.random(30, VIRTUAL_HEIGHT-35)

    self.width = 5
    self.height = math.random(30, 70)
end

function Hurdle:update(dt)
end

function Hurdle:render()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end