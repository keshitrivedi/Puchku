TitleScreenState = Class { __includes = BaseState }

local background = love.graphics.newImage('graphics/TitleScreenBackground.png')
local backgroundScroll = 0
local BACKGROUND_SCROLL_SPEED = 30

local BACKGROUND_LOOPING_POINT = 640

function TitleScreenState:update(dt)
    if love.keyboard.wasPressed("return") then
        gStateMachine:change('play')
    end

    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
end

function TitleScreenState:render()
    love.graphics.draw(background, -backgroundScroll, 0)

    love.graphics.setFont(bigFont)
    love.graphics.printf('PUCHKU', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Press Enter', 0, 100, VIRTUAL_WIDTH, 'center')
end