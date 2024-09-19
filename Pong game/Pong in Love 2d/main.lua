
--Made by Jspider_ eifhkgfjrjknfsjke
require "ball"
require "dash_line"

local pixel_font = love.graphics.newFont("PublicPixel-rv0pA.ttf",75)
local pixel_font_smaller = love.graphics.newFont("PublicPixel-rv0pA.ttf",40)

local screen_width = 1000
local screen_height = 600

local cooldown = 0
local cooldown_2 = 0

local score_player_1 = 0
local score_player_2 = 0

local game_state

local min_to_win = 2
--Players

--Player 1
local player = {}
player.x = 50
player.y = screen_height / 2
player.speed =10 * 60
player.width = 25
player.height = 100

--Player 2
local player_2 = {}
player_2.x = 925
player_2.y = screen_height / 2
player_2.speed = 10 * 60
player_2.width = 25
player_2.height = 100



--Setting the FPS to 60
dt = 1 / 60


function love.load()
    love.window.setMode(screen_width,screen_height,{resizable=false, vsync=0})

    ball = Ball:new(screen_width/2,screen_height/2,0.8,1.0,12)

    game_state = "start"
end

function love.update(dt)
    if game_state == "main" then
        --Movement of the characters
        cooldown = cooldown -1
        cooldown_2 = cooldown_2 -1
        if love.keyboard.isDown("w")then
            if player.y > 25 then
                player.y = player.y - (player.speed * dt)
            end
        end
        if love.keyboard.isDown("s")then
            if player.y < 475 then
                player.y = player.y + (player.speed * dt)
            end
        end

        if love.keyboard.isDown("up")then
            if player_2.y > 25 then
                player_2.y = player_2.y - (player_2.speed * dt)
            end
        end
        if love.keyboard.isDown("down")then
            if player_2.y < 475 then
                player_2.y = player_2.y + (player_2.speed * dt)
            end
        end

        --Other shit idk
        Ball.move(ball)
        if (ball.x < (player.x + 25)) and (ball.x > (player.x)) and (ball.y > player.y) and ball.y < (player.y + 100) and cooldown < 0 then
            ball.xVel = ball.xVel * -1
            cooldown = 20
        end
        if (ball.x > (player_2.x)) and (ball.x < (player_2.x + 25)) and (ball.y > player_2.y) and ball.y < (player_2.y + 100) and cooldown_2 < 0 then
            ball.xVel = ball.xVel * -1
            cooldown_2 = 20
        end

        --Score stuff
        if ball.x - ball.radius < 0 then
            score_player_2 = score_player_2 +1
            if score_player_2 == min_to_win then
                game_state = "winner"
            end

        elseif ball.x + ball.radius > love.graphics.getWidth() then
            score_player_1 = score_player_1 + 1
            if score_player_1 == min_to_win then
                game_state = "winner"
            end
        end
        
        
        Ball.checkEdges(ball)

    end

    if love.keyboard.isDown("space") then
        game_state = "main"
    end
end

function love.draw()
    love.graphics.setColor(1,1,1)
    if game_state ~= "winner" then
        love.graphics.rectangle("fill",player.x,player.y,player.width,player.height)
        love.graphics.rectangle("fill",player_2.x,player_2.y,player_2.width,player_2.height)

        lineStipple(500,0,500,600,10,10)

        love.graphics.setFont(pixel_font)
        love.graphics.print(tostring(score_player_1),400,50)
        love.graphics.print(tostring(score_player_2),525,50)
        Ball.show(ball)

        if game_state == "start" then
            love.graphics.setColor(1,0,0)
            love.graphics.setFont(pixel_font_smaller)
            love.graphics.print("Press space to Start!",100,300)
        end
    end
    if game_state == "winner" then
        local win_text
        if score_player_1 == min_to_win then
            win_text = "Player 1 wins"
        else
            win_text = "Player 2 wins"
        end
        love.graphics.print(win_text,20 ,200)
    end
end