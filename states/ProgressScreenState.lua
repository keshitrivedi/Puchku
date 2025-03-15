ProgressScreenState = Class{__includes = BaseState}

function ProgressScreenState:init()
    tiayay = love.graphics.newImage('graphics/tiayay.png')
    puchkuyay = love.graphics.newImage('graphics/puchkuyay.png')
    confetti = love.graphics.newImage('graphics/confetti.png')
end

function ProgressScreenState:update()
    if love.keyboard.wasPressed('p') then
        gStateMachine:change('play')
    end
end

function ProgressScreenState:render()
    love.graphics.draw(confetti, 0, 0)
    love.graphics.printf('PUCHKU COLLECTED!', 0, 100, VIRTUAL_WIDTH, 'center')
    love.graphics.printf(tostring(gGang:getCount()).."/15", 0, 120, VIRTUAL_WIDTH, "center")
    love.graphics.printf('press p to continue', 0, 140, VIRTUAL_WIDTH, 'center')

    love.graphics.draw(puchkuyay, 30, 50, 0, 7, 7)
    love.graphics.draw(tiayay, VIRTUAL_WIDTH-170, 50, 0, 7, 7)
end