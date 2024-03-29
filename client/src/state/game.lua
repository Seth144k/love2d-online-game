require("src.player")

game = {}

function game:enter()
    client:connect()
    client:on("playerNum", function(num)
        playerNumber = num
    end)
    tickRate = 1/60
    tick = 0
    player:load()
end

function game:draw()
    --love.graphics.print(tostring(playerNumber))
    player:draw()
end

function game:update(dt)
    client:update()

    if client:getState() == "connected" then
        tick = tick + dt
    end

    if tick >= tickRate then
        player:update(dt)
    end
end