punteggio = {}

function punteggio:draw()
    love.graphics.setFont(font)
    love.graphics.print("Player1 : "..Score.player1, 100, 50)
    if gameMode == "1vs1" then
        love.graphics.print("Player2 : "..Score.player2, 1020, 50)
    else
        love.graphics.print("AI : "..Score.ai, 1150, 50)
    end
end