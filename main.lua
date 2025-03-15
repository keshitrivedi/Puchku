push = require 'push'

Class = require 'class'

require 'StateMachine'

require 'Puchku'
require 'PuchkuGang'
require 'MainCharacter'
require 'Hurdle'
require 'HurdleGang'

require 'states/BaseState'
require 'states/PlayState'
require 'states/TitleScreenState'
require 'states/ProgressScreenState'
require 'states/WinningScreenState'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

gLevel = 1

function love.load()
    print("Started")
    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('Puchku')

    math.randomseed(os.time())

    smallFont = love.graphics.newFont('fonts/font.ttf', 8)
    mediumFont = love.graphics.newFont('fonts/bold.ttf', 14)
    bigFont = love.graphics.newFont('fonts/bold.ttf', 28)
    hugeFont = love.graphics.newFont('fonts/bold.ttf', 56)
    love.graphics.setFont(bigFont)

    sounds = {
        ['collide'] = love.audio.newSource('sounds/collision.wav', 'static'),
        ['levelup'] = love.audio.newSource('sounds/levelup.wav', 'static'),
        ['winning'] = love.audio.newSource('sounds/winning2.wav', 'static'),

        --https://pixabay.com/music/video-games-retro-game-arcade-236133/
        ['bgm'] = love.audio.newSource('sounds/bgm.mp3', 'static')
    }

    sounds['bgm']:setLooping(true)
    sounds['bgm']:play()

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    gStateMachine = StateMachine {
        ['title'] = function() return TitleScreenState() end,
        ['play'] = function() return PlayState() end,
        ['progress'] = function() return ProgressScreenState() end,
        ['finish'] = function() return WinningScreenState() end
    }
    gStateMachine:change('title')

    love.keyboard.keysPressed = {}

    love.mouse.buttonsPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
        love.event.quit()
    end
end

function love.mousepressed(x, y, button)
    love.mouse.buttonsPressed[button] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.mouse.wasPressed(button)
    return love.mouse.buttonsPressed[button]
end

function love.update(dt)

    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed = {}
end

function love.draw()
    push:start()

    gStateMachine:render()

    push:finish()
end
