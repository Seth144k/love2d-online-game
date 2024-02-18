sock = require("lib.sock")
bitser = require("lib.bitser")
require("src.player")

function love.load()
    -- start server
    server = sock.newServer("*", 22122, 2)
    tickRate = 1/60
    tick = 0
    server:setSerialization(bitser.dumps, bitser.loads)
    server:on("connect", function(data, client)
        -- tell the peer what their index is
        client:send("playerNum", client:getIndex())
    end)

    player:load()
end

function love.draw()
    player:draw()
    love.graphics.print(tostring(server:getClientCount()))
end

function love.update(dt)
    server:update()
    -- wait until 2 players connect to start playing
    local enoughPlayers = #server.clients >= 2
    if not enoughPlayers then return end
    tick = tick + dt
    if tick >= tickRate then
        tick = 0

        player:update(dt)
    end
end