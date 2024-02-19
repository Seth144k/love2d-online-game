require("src.player")

lobby = {}

function lobby:enter()
end

function lobby:draw()
    love.graphics.rectangle("fill", love.graphics.getWidth()/2-10, love.graphics.getHeight()/2-1000, 10, 10000)
    love.graphics.print(tostring(playerNumber))
end

function lobby:update(dt)
end