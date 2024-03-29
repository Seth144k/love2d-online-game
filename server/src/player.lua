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
    self.players = {
        self:new(40, 40),
        self:new(720, 520)
    }

    server:on("playerY", function(y, client)
        local index = client:getIndex()
        self.players[index].y = y
    end)

    server:on("playerX", function(x, client)
        local index = client:getIndex()
        self.players[index].x = x
    end)
    server:on("playerCoinsCollected", function(coins, client)
        local index = client:getIndex()
        self.players[index].coinsCollected = coins
    end)
end

function player:draw()
    for i, p in pairs(self.players) do
        love.graphics.rectangle('fill', p.x, p.y, p.width, p.height)
    end
end

function player:update(dt)
    for i, p in pairs(self.players) do
        server:sendToAll("playerState", {i, p})
    end
end