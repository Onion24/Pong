gameOver = {}

function gameOver:draw()
    love.graphics.draw(vittoria, -40, -200)
    love.graphics.setFont(love.graphics.newFont("fonts/px.otf",150))
    love.graphics.setColor(1,0.5,0)
    love.graphics.printf("Vincitore: "..vincitore, 0, love.graphics.getHeight() / 5, love.graphics.getWidth(), "center")
    love.graphics.setColor(1,1,1)

    love.graphics.setFont(font)
    local startButtonX = love.graphics.getWidth() / 2 - 150
    local startButtonY = love.graphics.getHeight() / 2
    local buttonWidth = 300
    local buttonHeight = 50
    local buttonradius = 15

    love.graphics.setColor(1, 0.5, 0.1, 0.8)

    love.graphics.rectangle("fill", startButtonX, startButtonY, buttonWidth, buttonHeight, buttonradius)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("TORNA AL MENU", startButtonX, startButtonY + 8, buttonWidth, "center")
end