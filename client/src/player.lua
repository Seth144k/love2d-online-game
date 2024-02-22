player = {}

function player:new(x, y)
    return {
        x = x,
        y = y,
        width = 40,
        height = 40,
        coinsCollected = 0
    }
end

function player:load()
    client:setSchema("playerState", {
        "index",
        "player",
    })
    self.players = {
        self:new(40, 40),
        self:new(720, 520)
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

local c

function player:draw()
    for i, p in pairs(self.players) do
        love.graphics.rectangle('fill', p.x, p.y, p.width, p.height)
    end
    love.graphics.print(tostring(e))
end

function player:update(dt)
    if playerNumber then
        local speed = 200
        local playerY = self.players[playerNumber].y
        local playerX = self.players[playerNumber].x
        local coinsCollected = self.players[playerNumber].coinsCollected
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
        if love.keyboard.isDown("f") then
            coinsCollected = coinsCollected + 1
        end
        -- send player data to the server
        self.players[playerNumber].y = playerY
        self.players[playerNumber].x = playerX
        self.players[playerNumber].coinsCollected = coinsCollected
        c = coinsCollected
        e = self.players[playerNumber].coinsCollected
        client:send("playerY", playerY)
        client:send("playerX", playerX)
        client:send("playerCoinsCollected", coinsCollected)
    end
end