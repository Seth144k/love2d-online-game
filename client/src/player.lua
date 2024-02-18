player = {}

function player:new(x, y)
    return {
        x = x,
        y = y,
        width = 40,
        height = 40,
    }
end

function player:load()
    client:setSchema("playerState", {
        "index",
        "player",
    })
    self.players = {
        self:new(40, 40),
        self:new(100, 200)
    }
    -- receive info on where the players are located
    client:on("playerState", function(data)
        local index = data.index
        local player = data.player

        -- only accept updates for the other player
        if playerNumber and index ~= playerNumber then
            self.players[index] = player
        end
    end)
end

function player:draw()
    for _, p in pairs(self.players) do
        love.graphics.rectangle('fill', p.x, p.y, p.width, p.height)
    end
    love.graphics.print("Your ping: "..tostring(client:getRoundTripTime()))
end

function player:update(dt)
    if playerNumber then
        local speed = 200
        local playerY = self.players[playerNumber].y
        local playerX = self.players[playerNumber].x
        if love.keyboard.isDown("w") then
            playerY = self.players[playerNumber].y - speed * dt
        end
        if love.keyboard.isDown("s") then
            playerY = self.players[playerNumber].y + speed * dt
        end
        if love.keyboard.isDown("a") then
            playerX = self.players[playerNumber].x - speed * dt
        end
        if love.keyboard.isDown("d") then
            playerX = self.players[playerNumber].x + speed * dt
        end
        -- Update our own player position and send it to the server
        self.players[playerNumber].y = playerY
        self.players[playerNumber].x = playerX
        client:send("playerY", playerY)
        client:send("playerX", playerX)
    end
end