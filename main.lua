--ball, paddle, and frame initialization
ball = {}
ball.x = 300
ball.y = 200
ball.vel = {}
ball.vel.x = 3
ball.vel.y = 1
ball.height = 30
ball.width = 30

map = {}
map.offset = 90
map.width = 600
map.height = 400

player1 = {}
player1.width = 10
player1.height = 50
player1.y = 200
player1.x = 110

player2 = {}
player2.width = 10
player2.height = 50
player2.y = 200
player2.x = 660

player2.score = 0
player1.score = 0

function love.load()
    --[[set love's default filter to "nearest-neighbor", which essentially
    means there will be no filtering of pixels (blurriness), which is
    important for a nice crisp, 2D look]]
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- setting the title of our application window
    --love.window.setTitle('Pong')

    -- seed the RNG so that calls to random are always random
    math.randomseed(os.time())

    -- font initialization 
	smallFont = love.graphics.newFont('font.ttf', 20)
	scoreFont = love.graphics.newFont('font.ttf', 60)
	scoreFont1 = love.graphics.newFont('font.ttf', 30)

    -- sounds initialization
    sounds = {
        ['paddle_hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
        ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static')
    }
end

function love.update()
	ball.x = ball.x + ball.vel.x * 1.03
	ball.y = ball.y + ball.vel.y * 1.03
	
	--map boundaries
	--right side
	if ball.x >= (map.width + map.offset) - ball.width then
		player1.score = player1.score + 1
		ball:reset()
		sounds['score']:play()
	end
	--left side
	if ball.x <= map.offset + (ball.width - 5) then
		player2.score = player2.score + 1
		ball:reset()
		sounds['score']:play()
	end

	--walls bounce
	--up
	if ball.y <= map.offset + (ball.width - 5) then
		ball:bounce(1, -1)
		sounds['wall_hit']:play()
	end
	--down
	if ball.y >= (map.height + map.offset) - ball.height then
		ball:bounce(1, -1)
		sounds['wall_hit']:play()
	end
	
	--paddles bounces
	--player1 paddle
	if ball.x < player1.x + 15 and ball.y <= player1.y + player1.height and ball.y >= player1.y - ball.height then
		ball:bounce(-1, 1)
		ball.x = ball.x + 10
		sounds['paddle_hit']:play()
	end
	--player2 paddle
	if ball.x > player2.x - 5 and ball.y <= player2.y + player2.height and ball.y >= player2.y - ball.height then
		ball:bounce(-1, 1)
		ball.x = ball.x - 10
		sounds['paddle_hit']:play()
	end 

	--keys testing / controllers
	--player2 (Left)
    if love.keyboard.isDown("up") and player2.y > map.offset then
		player2.y = player2.y - 2
    end
    if love.keyboard.isDown("down") and player2.y + player2.height < map.height + map.offset then
		player2.y = player2.y + 2
	end
	--player1 (right)
    if love.keyboard.isDown("w") and player1.y > map.offset then
		player1.y = player1.y - 2
    end
    if love.keyboard.isDown("s") and player1.y + player1.height < map.height + map.offset then
		player1.y = player1.y + 2
    end
end

function ball:bounce(x, y)
		self.vel.x = x * self.vel.x
		self.vel.y = y * self.vel.y
end

function ball:reset()
	ball.x = 300
	ball.y = 200
	ball.vel = {}
	ball.vel.x = 3
	ball.vel.y = 1
	ball.height = 30
	ball.width = 30
end

--Application Start up still on going
--[[function winOpen()
	love.graphics.print("WELCOME TO PONG", 320,200)
	love.graphics.print("press enter to play", 280,300)
end]]

function love.draw()
	--game color and font
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.setFont(scoreFont1)
	love.graphics.print("PONG", 350,20)

	local x, y = 0, 0
	local width, height = 100, 100
	local border_width = 20
	local border_radius = 10

	--love.graphics.line(395, 90, 395, 490) //centerline not dotted

	--border
	--change the border
	love.graphics.rectangle("line", map.offset, map.offset, map.width, map.height, 5, 5, segments)
	love.graphics.setLineWidth(border_width)

	--ball
	love.graphics.circle("fill", ball.x, ball.y, 15)

	--center line (draft only)
	love.graphics.circle("fill", 395, 100, 5)
	love.graphics.circle("fill", 395, 115, 5)
	love.graphics.circle("fill", 395, 130, 5)
	love.graphics.circle("fill", 395, 145, 5)
	love.graphics.circle("fill", 395, 160, 5)
	love.graphics.circle("fill", 395, 175, 5)
	love.graphics.circle("fill", 395, 190, 5)
	love.graphics.circle("fill", 395, 205, 5)
	love.graphics.circle("fill", 395, 220, 5)
	love.graphics.circle("fill", 395, 235, 5)
	love.graphics.circle("fill", 395, 250, 5)
	love.graphics.circle("fill", 395, 265, 5)
	love.graphics.circle("fill", 395, 280, 5)
	love.graphics.circle("fill", 395, 295, 5)
	love.graphics.circle("fill", 395, 310, 5)
	love.graphics.circle("fill", 395, 325, 5)
	love.graphics.circle("fill", 395, 340, 5)
	love.graphics.circle("fill", 395, 355, 5)
	love.graphics.circle("fill", 395, 370, 5)
	love.graphics.circle("fill", 395, 385, 5)
	love.graphics.circle("fill", 395, 400, 5)
	love.graphics.circle("fill", 395, 415, 5)
	love.graphics.circle("fill", 395, 430, 5)
	love.graphics.circle("fill", 395, 445, 5)
	love.graphics.circle("fill", 395, 460, 5)
	love.graphics.circle("fill", 395, 475, 5)

	--paddles
	--love.graphics.rectangle( mode, x, y, width, height, rx, ry, segments) -syntax
	love.graphics.rectangle("fill", player2.x, player2.y, player2.width, player2.height, 5, 5, segments)
	love.graphics.rectangle("fill", player1.x, player1.y, player1.width, player1.height, 5, 5, segments)

	--draw score
	displayScore()
	
	--draw line middle
	--change this into dotted line
	

	--display fps
	displayFPS()
end

function displayScore()
	love.graphics.setFont(scoreFont)
	love.graphics.print(player2.score, 520, 120)
	love.graphics.print(player1.score, 220, 120)
end

function displayFPS()
    -- simple FPS display across all states
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end


