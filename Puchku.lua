Puchku = Class{}

function Puchku:init()
    self.image = love.graphics.newImage('graphics/puchkusquare.png')
    
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = VIRTUAL_WIDTH/4 - self.width/2
    self.y = VIRTUAL_HEIGHT/2 - self.height/2

    self.dx = 0
    self.dy = 0
end

function Puchku:hurdleCollides(hurdles)
    for _, hurdle in ipairs(hurdles) do
        if self.x < hurdle.x + hurdle.width and
           self.x + self.width > hurdle.x and
           self.y < hurdle.y + hurdle.height and
           self.y + self.height > hurdle.y then

            local variation = function(value)
                return value * (1 + (math.random(-10, 10) / 100))
            end

            if self.x + self.width - self.dx <= hurdle.x or self.x - self.dx >= hurdle.x + hurdle.width then
                self.dx = -variation(self.dx)
            end

            if self.y + self.height - self.dy <= hurdle.y or self.y - self.dy >= hurdle.y + hurdle.height then
                self.dy = -variation(self.dy)
            end
        end
    end
end

function Puchku:update(dt)
    self.x = self.x + self.dx*dt
    self.y = self.y + self.dy*dt
end

function Puchku:render()
    love.graphics.draw(self.image, self.x, self.y)
end