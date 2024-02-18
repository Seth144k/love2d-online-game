sock = require("lib.sock")
bitser = require("lib.bitser")
gamestate = require("lib.gamestate")
require("suit")
require("src.state.title")

function love.load()
    gamestate.registerEvents()
    gamestate.switch(title)
    client:on("disconnect", function()
        client:disconnect()
    end)
end

function love.textedited(text, start, length)
    -- for IME input
    suit.textedited(text, start, length)
end

function love.textinput(t)
	-- forward text input to SUIT
	suit.textinput(t)
end

function love.keypressed(key)
    suit.keypressed(key)
end

function love.draw()
    --love.graphics.rectangle("fill", love.graphics.getWidth()/2-10, love.graphics.getHeight()/2-1000, 10, 10000)
    love.graphics.print("You are player "..tostring(playerNumber), 0, 16)
    suit.draw()
end

function love.update(dt)
end