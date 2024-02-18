suit = require("suit")
require("src.state.game")

title = {}

function title:enter()
    client = sock.newClient("25.57.114.243", 22122)
    client:setSerialization(bitser.dumps, bitser.loads)
    client:enableCompression()
end

serverCode = {text = ""}
function title:update(dt)
    suit.Input(serverCode, 100, 300, 60, 70)
    if suit.Button("Connect", 100, 200, 60, 70).hit then
        --client:connect(tonumber(input.text))
        gamestate.push(game)
    end
end