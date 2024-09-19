Ball = {}
Ball.x = 0
Ball.y = 0
Ball.radius = 0
Ball.xVel = 0
Ball.yVel = 0


function Ball:new(x,y,xVel,yVel,radius)
    t = {
        x = x,
        y = y,
        radius = radius,
        xVel = xVel,
        yVel = yVel
    }
    setmetatable(t,self)
    self.__index = self
    return t
end

function Ball:move()

    self.x = self.x + self.xVel
    self.y = self.y + self.yVel

end

function Ball:checkEdges()

    if self.x + self.radius > love.graphics.getWidth() or self.x - self.radius < 0 then
        self.x = love.graphics.getWidth() / 2
        self.y = love.graphics.getHeight() / 2
        self.xVel = self.xVel * -1
    end
    if self.y + self.radius > love.graphics.getHeight() or self.y - self.radius < 0 then
        self.yVel = self.yVel * -1
    end
end

function Ball:show()

    love.graphics.ellipse("fill",self.x,self.y,self.radius)

end