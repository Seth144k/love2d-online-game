suit = require("suit")
require("src.state.game")

title = {}

function title:enter()
    client = sock.newClient("localhost", 22122)
    client:setSerialization(bitser.dumps, bitser.loads)
    client:enableCompression()
end

function title:draw()
    suit.draw()
end

function title:update(dt)
    if suit.Button("Connect", 100, 200, 60, 70).hit then
        gamestate.push(game)
    end
end