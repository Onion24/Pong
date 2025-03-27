Background = {}

function Background:load()

    self.sky = love.graphics.newImage("sprites/sky.jpg")
    self.starry = love.graphics.newImage("sprites/starry.png")
end

function Background:update(dt)
end

function Background:draw()
    love.graphics.draw(self.sky, -40, -200)


end
