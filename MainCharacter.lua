MainCharacter = Class{}

function MainCharacter:init()
    self.image = love.graphics.newImage('graphics/tiav1.png')

    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = VIRTUAL_WIDTH/2 - self.width/2
    self.y = VIRTUAL_HEIGHT/2 - self.height/2

    self.dy = 0
    self.dx = 0
end

function MainCharacter:collides(puchku)
    if self.x > puchku.x + puchku.width or puchku.x > self.x + self.width then
        return false
    end
    if self.y > puchku.y + puchku.height or puchku.y > self.y + self.height then
        return false
    end
    return true
end

function MainCharacter:hurdleCollides(hurdles)
    for _, hurdle in ipairs(hurdles) do
        if self.x < hurdle.x + hurdle.width and
           self.x + self.width > hurdle.x and
           self.y < hurdle.y + hurdle.height and
           self.y + self.height > hurdle.y then

            if self.x + self.width - self.dx <= hurdle.x then
                self.x = hurdle.x - self.width
            elseif self.x - self.dx >= hurdle.x + hurdle.width then
                self.x = hurdle.x + hurdle.width
            end

            if self.y + self.height - self.dy <= hurdle.y then
                self.y = hurdle.y - self.height
            elseif self.y - self.dy >= hurdle.y + hurdle.height then
                self.y = hurdle.y + hurdle.height
            end
        end
    end
end

function MainCharacter:update(dt)
    self.dx = 0
    self.dy = 0

    if love.keyboard.isDown("left") then
        self.dx = -100
    elseif love.keyboard.isDown("right") then
        self.dx = 100
    end

    if love.keyboard.isDown("up") then
        self.dy = -100
    elseif love.keyboard.isDown("down") then
        self.dy = 100
    end

    self.x = math.max(0, math.min(VIRTUAL_WIDTH - self.width, self.x + self.dx * dt))
    self.y = math.max(0, math.min(VIRTUAL_HEIGHT - self.height, self.y + self.dy * dt))
end

function MainCharacter:render()
    love.graphics.draw(self.image, self.x, self.y)
end