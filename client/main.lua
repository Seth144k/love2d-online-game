sock = require("lib.sock")
bitser = require("lib.bitser")
gamestate = require("lib.gamestate")
require("src.state.title")

function love.load()
    gamestate.registerEvents(nil)
    gamestate.switch(title)
    client:on("disconnect", function()
        client:disconnect()
    end)
    client:on("image", function(data)
        local file = love.filesystem.newFileData(data, "")
        receivedImage = love.image.newImageData(file)
        receivedImage = love.graphics.newImage(receivedImage)
    end)
end

function love.draw()
    love.graphics.rectangle("fill", love.graphics.getWidth()/2-10, love.graphics.getHeight()/2-1000, 10, 10000)
end

function love.update(dt)
    return nil
end