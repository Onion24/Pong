Menu = {}

function Menu:draw()
    love.graphics.draw(menu, -40, -200)
    love.graphics.setFont(love.graphics.newFont("fonts/px.otf",150))
    love.graphics.setColor(255,215,0)
    love.graphics.printf("Pong Game", 0, love.graphics.getHeight() / 5, love.graphics.getWidth(), "center")

    love.graphics.setFont(font)
    local startButtonX = love.graphics.getWidth() / 2 - 150
    local startButtonY = love.graphics.getHeight() / 2
    local buttonWidth = 300
    local buttonHeight = 50
    local buttonradius = 15

    love.graphics.setColor(1, 0.5, 0.1, 0.8)

    love.graphics.rectangle("fill", startButtonX, startButtonY, buttonWidth, buttonHeight, buttonradius)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("1 VS AI", startButtonX, startButtonY + 8, buttonWidth, "center")

    love.graphics.setColor(1, 0.5, 0.1, 0.8)
    local start2ButtonY = startButtonY + 70
    love.graphics.rectangle("fill", startButtonX, start2ButtonY, buttonWidth, buttonHeight, buttonradius)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("1 VS 1", startButtonX, start2ButtonY + 8, buttonWidth, "center")

    love.graphics.setColor(1, 0.5, 0.1, 0.8)
    local exitButtonY = start2ButtonY + 70
    love.graphics.rectangle("fill", startButtonX, exitButtonY, buttonWidth, buttonHeight, buttonradius)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("Exit", startButtonX, exitButtonY + 8, buttonWidth, "center")
end