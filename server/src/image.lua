image = {}

function image:load()
    client:on("image", function(data)
        local file = love.filesystem.newFileData(data, "")
        receivedImage = love.image.newImageData(file)
        receivedImage = love.graphics.newImage(receivedImage)
    end)
    self.x = 0
    self.y = 0
    self.width = 0
    self.height = 0
end

function image:send(name, x, y, width, height)
    local image = love.filesystem.newFileData("res/"..name..".png")
    server:sendToAll("image", image)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
end