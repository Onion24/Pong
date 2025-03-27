gameState = "menu" -- Stati possibili: "menu" o "play"
gameMode = "1vsAI" -- Modalità possibili: "1vsAI" o "1vs1"

require("assets/giocatori/player") --Richiedere gli altri file che servono
require("assets/ball")
require("assets/giocatori/ai")
require("assets/grafica/background")
require("assets/giocatori/player2")
require("assets/grafica/menu")
require("assets/grafica/gameOver")
require("assets/grafica/pauseScreen")
require("assets/grafica/punteggio")

function love.load()  -- Funzione base dove mettere variabili
    Background:load() --Bisogna aggiungere i .load() degli altri file (se serve)
    Player:load()
    Player2:load()
    Ball:load()
    AI:load()

    Score = {player1 = 0, player2 = 0, ai = 0}
    font = love.graphics.newFont("fonts/px.otf",40)

    Sounds = {}
    Sounds.music = love.audio.newSource('sounds/forest.mp3', 'stream')
    Sounds.music:setLooping(true)
    Sounds.colpo = love.audio.newSource('sounds/colpo.mp3', 'static')
    Sounds.puntoA = love.audio.newSource('sounds/puntoA.mp3', 'static')
    Sounds.puntoP = love.audio.newSource('sounds/puntoP.mp3', 'static')

    vincitore = nil

    pausa = love.graphics.newImage("sprites/pausa.jpg")
    menu = love.graphics.newImage('sprites/menu.jpg')
    vittoria = love.graphics.newImage("sprites/vittoria.jpg")

end

function love.update(dt) --Funzione base dove dt cambia ogni frame
    if gameState == "play" then
        Background:update(dt)
        Player:update(dt)        
        if gameMode == "1vs1" then
            Player2:update(dt)            
        else
            AI:update(dt)
        end
        Ball:update(dt)
        if controlloVittoria() then
            gameState = "termine"
        end        
    end
end

function love.draw()  --Funzione base dove si disegnano le pagine/entità
    if gameState == "menu" then
        Menu:draw()
        resetPunteggi()
    elseif gameState == "play" then
        Background:draw()
        punteggio:draw()
        Player:draw()
        if gameMode == "1vsAI" then
            AI:draw()
        else
        Player2:draw()
        end
        Ball:draw()
    elseif gameState == "pausa" then
        pauseScreen:draw()
    elseif gameState == "termine" then
        gameOver:draw()
    end
end

function love.keypressed(key) --Funzione per aggiungere comandi premendo pulsanti
    if key == "p" then
        if gameState == "play" then
            gameState = "pausa"  
        elseif gameState == "pausa" then
            gameState = "play"   
        end
    end
end

function love.mousepressed(x, y, button, istouch, presses) --Funzione per vedere dove avviene il click e cosa fare
    if gameState == "menu" and button == 1 then
        local startButtonX = love.graphics.getWidth() / 2 - 150
        local startButtonY = love.graphics.getHeight() / 2
        local buttonWidth = 300
        local buttonHeight = 50

        --controllo se il click è sopra il pulsante 1vsAI
        if x > startButtonX and x < startButtonX + buttonWidth and y > startButtonY and y < startButtonY + buttonHeight then
            gameState = "play"
            gameMode = "1vsAI"
            Sounds.music:play()
        end

        local start2ButtonY = startButtonY + 70
        --controllo se il click è sopra il pulsante 1vs1
        if x > startButtonX and x < startButtonX + buttonWidth and y > start2ButtonY and y < start2ButtonY + buttonHeight then
            gameState = "play"
            gameMode = "1vs1"
            Sounds.music:play()
        end

        
        local exitButtonY = start2ButtonY + 70

        --controllo se il click è sopra il pulsante exit
        if x > startButtonX and x < startButtonX + buttonWidth and y > exitButtonY and y < exitButtonY + buttonHeight then
            love.event.quit()
        end
    end
    if gameState == "termine" and button == 1 then
        local startButtonX = love.graphics.getWidth() / 2 - 150
        local startButtonY = love.graphics.getHeight() / 2
        local buttonWidth = 300
        local buttonHeight = 50

        --controllo se il click è sopra il pulsante menu
        if x > startButtonX and x < startButtonX + buttonWidth and y > startButtonY and y < startButtonY + buttonHeight then
            gameState = "menu"
            Sounds.music:stop()
        end
    end

    if gameState == "pausa" and button == 1 then
        local startButtonX = love.graphics.getWidth() / 2 - 150
        local startButtonY = love.graphics.getHeight() / 2 + 200
        local buttonWidth = 300
        local buttonHeight = 50

        --controllo se il click è sopra il pulsante menu
        if x > startButtonX and x < startButtonX + buttonWidth and y > startButtonY and y < startButtonY + buttonHeight then
            gameState = "menu"
            Sounds.music:stop()
        end
    end

end

function controlloCollisioni(a, b) --Funzione per controllare l'avvenimento di collisioni tra "rettangoli"
    return a.x + a.width > b.x and a.x < b.x + b.width and a.y + a.height > b.y and a.y < b.y + b.height
end

function controlloVittoria() --Funzione per controllare se avviene una vincita e chi è il vincitore
    for player, score in pairs(Score) do
        if score == 5 then
            vincitore = player
            return true
        end
    end
    return false
end


function resetPunteggi() --Funzione per resettare i punteggi
    Score.player1 = 0
    Score.player2 = 0
    Score.ai = 0
end
