host = {}

function host:load()
    self.code = {text = ""}
    self.server = sock.newServer("*", tonumber(self.code), 2)
    tickRate = 1/60
    tick = 0
end

function host:draw()
    love.graphics.print("You are hosting on port "..tostring(self.server:getPort()), 0, 16)
end

function host:update(dt)
    suit.Input(self.code, 100, 300, 60, 70)
    if suit.Button("Start Hosting", 100, 200, 60, 70).hit then
        self.server:enableCompression()
        self.server:setSerialization(bitser.dumps, bitser.loads)
        self.server:on("connect", function(data, client)
            -- tell the peer what their index is
            client:send("playerNum", client:getIndex())
        end)
    end
end