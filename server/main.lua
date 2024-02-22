sock = require("lib.sock")
bitser = require("lib.bitser")
require("src.player")

function love.load()
    local num
    -- start server
    server = sock.newServer("*", num, 2)
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
    --love.graphics.print("Connected players: "..tostring(server:getClientCount()))
end

function love.update(dt)
    server:update()
    num = server:getPort()
    tick = tick + dt
    if tick >= tickRate then
        tick = 0
        player:update(dt)
    end
end