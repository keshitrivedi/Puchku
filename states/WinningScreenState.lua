WinningScreenState = Class{__includes = BaseState}

function WinningScreenState:init()
    background = love.graphics.newImage('graphics/lawn.png')
    tiafinish = love.graphics.newImage('graphics/tiayay.png')
end

function WinningScreenState:update(dt)
end

function WinningScreenState:render()
    love.graphics.draw(background, 0, 0)
    love.graphics.printf("Finish!", 0, 20, VIRTUAL_WIDTH, 'center')
    love.graphics.draw(tiafinish, 180, 50, 0, 7, 7)
end