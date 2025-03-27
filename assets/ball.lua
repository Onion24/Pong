Ball = {}

function Ball:load()
    anim8 = require 'libraries/anim8'
    love.graphics.setDefaultFilter('nearest','nearest')

    -- Carica il foglio sprite e configura anim8
    self.spriteSheet = love.graphics.newImage('sprites/ball.png')
    self.grid = anim8.newGrid(192, 192, self.spriteSheet:getWidth(), self.spriteSheet:getHeight())

    -- Animazione: usa i frame della prima riga ('1-3', 1)
    self.animation = anim8.newAnimation(self.grid('1-5', '1-4'), 0.2) -- 0.1 secondi per frame


    -- Configurazione di base
    self.x = love.graphics.getWidth() / 2
    self.y = love.graphics.getHeight() / 2
    self.width = 63 -- Larghezza del singolo frame
    self.height = 63 -- Altezza del singolo frame
    self.speed = 1000
    self.xvel = -self.speed
    self.yvel = 0

    -- Timer di attesa
    self.waiting = false
    self.waitTimer = 0
    self.waitDuration = 2 -- Attendi 2 secondi

    
end

function Ball:update(dt)
    if self.waiting then
        -- Gestisci il timer di attesa
        self.waitTimer = self.waitTimer + dt
        if self.waitTimer >= self.waitDuration then
            self.waiting = false
            self.waitTimer = 0
            self.speed = 1000
        end
    else
        self:move(dt)
        self:collide()
    end
    self.animation:update(dt)
    self.speed = self.speed + dt * 10
end

function Ball:move(dt)
    self.x = self.x + self.xvel * dt
    self.y = self.y + self.yvel * dt
end

function Ball:collide()
    self:collidePlayer()
    self:collidePlayer2()
    self:collideAI()
    self:collideBordi()
    self:score()
 
end

function Ball:collideBordi() --Funzione per mettere i limiti sopra e sotto per la palla
    if self.y < 0 then
        self.y = 0
        self.yvel = -self.yvel
        Sounds.colpo:play()
    elseif self.y + self.height > love.graphics.getHeight() then
        self.y = love.graphics.getHeight() - self.height
        self.yvel = -self.yvel
        Sounds.colpo:play()
    end
end



function Ball:collidePlayer() --Funzioni per le collisioni con i giocatori
    if controlloCollisioni(self, Player) then
        self.xvel = self.speed
        local middleball = self.y + self.height / 2
        local middleplayer = Player.y + Player.height / 2
        local collisionPosition = middleball - middleplayer
        self.yvel = collisionPosition * 5
        Sounds.colpo:play()
    end
end

function Ball:collidePlayer2()
    if controlloCollisioni(self, Player2) then
        self.xvel = -self.speed
        local middleball = self.y + self.height / 2
        local middleplayer2 = Player2.y + Player2.height / 2
        local collisionPosition = middleball - middleplayer2
        self.yvel = collisionPosition * 5
        Sounds.colpo:play()
    end
end

function Ball:collideAI()
    if controlloCollisioni(self, AI) then
        self.xvel = -self.speed
        local middleball = self.y + self.height / 2
        local middleai = AI.y + AI.height / 2
        local collisionPosition = middleball - middleai
        self.yvel = collisionPosition * 5
        Sounds.colpo:play()
    end
end

function Ball:score() --Funzione per segnare i punti ai giocatori in base al lato 
    if self.x < 0 then
        if gameMode == "1vsAI" then
            Score.ai = Score.ai + 1
        elseif gameMode == "1vs1" then
            Score.player2 = Score.player2 + 1
        end
        Sounds.puntoA:play()
        self:resetPosition(1)
    elseif self.x + self.width > love.graphics.getWidth() then
        Score.player1 = Score.player1 + 1
        Sounds.puntoP:play()
        self:resetPosition(-1)
    end
end



function Ball:resetPosition(modificatore) --Funzione per mettere la palla al centro dopo un punto e aspettare 2 secondi
    -- Attiva la modalità di attesa
    self.waiting = true
    self.x = love.graphics.getWidth() / 2 - self.width / 2
    self.y = love.graphics.getHeight() / 2 - self.height / 2
    self.yvel = 0
    self.xvel = -self.speed * modificatore
end

function Ball:draw()
    -- Disegna l'animazione della palla
    self.animation:draw(self.spriteSheet, self.x, self.y, 0, 0.5, 0.5, self.width / 2, self.height / 2)

end