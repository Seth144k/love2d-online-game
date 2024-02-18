sock = require("lib.sock")
bitser = require("lib.bitser")
require("src.player")

function love.load()
    -- start server
    server = sock.newServer("*", 22122, 2)
    server:enableCompression()
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
    love.graphics.print("Connected players: "..tostring(server:getClientCount()))
    love.graphics.print("You are hosting on port "..tostring(server:getPort()), 0, 16)
end

function love.update(dt)
    server:update()
    tick = tick + dt
    if tick >= tickRate then
        tick = 0
        player:update(dt)
    end
end