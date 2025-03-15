PlayState = Class{__includes = BaseState}

gGang = PuchkuGang()

local lawn

function PlayState:init()
    local lawns = {
        ['lawn1'] = love.graphics.newImage('graphics/lawn.png'),
        ['lawn2'] = love.graphics.newImage('graphics/lawn2.png'),
        ['lawn3'] = love.graphics.newImage('graphics/lawn3.png'),
        ['lawn4'] = love.graphics.newImage('graphics/lawn4.png')
    }
    
    lawnChanger = math.random(0, 40)
    
    if lawnChanger>=0 and lawnChanger<10 then
        lawn = lawns['lawn1']
    elseif lawnChanger>=10 and lawnChanger<20 then
        lawn = lawns['lawn2']
    elseif lawnChanger>=20 and lawnChanger<30 then
        lawn = lawns['lawn3']
    else
        lawn = lawns['lawn4']
    end

    self.tia = MainCharacter()
    self.puchku = Puchku()
    self.hurdle = Hurdle()

    self.hurdleGang = HurdleGang()
    self.hurdleGang:generateHurdles()

    self.gang = gGang

    local speed = 50

    self.puchku.dy = speed*(math.random(0, 1) == 0 and -1 or 1)
    self.puchku.dx = speed*(math.random(0, 1) == 0 and -1 or 1)

    self.hasCollided = false
end

function PlayState:update(dt)

    if self.puchku.x < 0 then
        self.puchku.x = 0
        self.puchku.dx = -self.puchku.dx
    elseif self.puchku.x > VIRTUAL_WIDTH - 10 then
        self.puchku.x = VIRTUAL_WIDTH - 10
        self.puchku.dx = -self.puchku.dx
    end

    if self.puchku.y < 0 then
        self.puchku.y = 0
        self.puchku.dy = -self.puchku.dy
    elseif self.puchku.y > VIRTUAL_HEIGHT - 10 then
        self.puchku.y = VIRTUAL_HEIGHT - 10
        self.puchku.dy = -self.puchku.dy
    end

    self.puchku.x = self.puchku.x + self.puchku.dx * dt
    self.puchku.y = self.puchku.y + self.puchku.dy * dt

    self.tia:update(dt)
    self.puchku:update(dt)

    if not self.hasCollided and self.tia:collides(self.puchku) then
        sounds['levelup']:play()
        gLevel = gLevel + 1
        print("Collision Detected")
        table.insert(self.gang.puchkus, Puchku())

        gStateMachine:change('progress')

        self.hasCollided = true
    end

    if gLevel == 16 then
        gStateMachine:change('finish')
        sounds['winning']:play()
    end

    self.tia:hurdleCollides(self.hurdleGang.hurdles)
    self.puchku:hurdleCollides(self.hurdleGang.hurdles)

    
    if gLevel > #self.hurdleGang.hurdles then
        self.hurdleGang:generateHurdles()
    end
    
end

function PlayState:render()
    love.graphics.draw(lawn, 0, 0)

    love.graphics.setColor(192/255, 70/255, 87/255, 1)
    self.hurdleGang:render()
    love.graphics.setColor(1, 1, 1, 1)
    self.tia:render()
    self.puchku:render()
end