pauseScreen = {}

function pauseScreen:draw()
    love.graphics.draw(pausa, -40, -200)
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(font)
    love.graphics.printf("Gioco in pausa", 0, love.graphics.getHeight() / 2 - 50, love.graphics.getWidth(), "center")
    love.graphics.printf("Premi P per continuare", 0, love.graphics.getHeight() / 2 + 20, love.graphics.getWidth(), "center")

    love.graphics.setFont(font)
    local startButtonX = love.graphics.getWidth() / 2 - 150
    local startButtonY = love.graphics.getHeight() / 2 + 200
    local buttonWidth = 300
    local buttonHeight = 50
    local buttonradius = 15

    love.graphics.setColor(1, 0.5, 0.1, 0.8)

    love.graphics.rectangle("fill", startButtonX, startButtonY, buttonWidth, buttonHeight, buttonradius)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("TORNA AL MENU", startButtonX, startButtonY + 8, buttonWidth, "center")
end