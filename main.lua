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

a = {}
a.width = 10
a.height = 50
a.y = 200
a.x = 660

b = {}
b.width = 10
b.height = 50
b.y = 200
b.x = 110

a.score = 0
b.score = 0

winningPlayer = 0

function love.load()
    -- set love's default filter to "nearest-neighbor", which essentially
    -- means there will be no filtering of pixels (blurriness), which is
    -- important for a nice crisp, 2D look
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- setting the title of our application window
    love.window.setTitle('Pong')

    -- seed the RNG so that calls to random are always random
    math.randomseed(os.time())

    -- font initialization 
    smallFont = love.graphics.newFont('font.ttf', 8)
    largeFont = love.graphics.newFont('font.ttf', 16)
    scoreFont = love.graphics.newFont('font.ttf', 50)
    love.graphics.setFont(smallFont)

    -- sounds initialization
    sounds = {
        ['paddle_hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
        ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static')
    }
    
end

function love.update()
	ball.x = ball.x + ball.vel.x
	ball.y = ball.y + ball.vel.y

	--map boundaries
	--right side
	if ball.x >= (map.width + map.offset) - ball.width then
		b.score = b.score + 1
		ball:reset()
		sounds['score']:play()
	end
	--left side
	if ball.x <= map.offset + (ball.width - 5) then
		a.score = a.score + 1
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
	if ball.x > a.x - 5 and ball.y <= a.y + a.height and ball.y >= a.y - ball.height then
		ball:bounce(-1, 1)
		ball.x = ball.x - 10
		sounds['paddle_hit']:play()
	end 
	

	if ball.x < b.x + 11 and ball.y <= b.y + b.height and ball.y >= b.y - ball.height then
		ball:bounce(-1, 1)
		ball.x = ball.x + 10
		sounds['paddle_hit']:play()
	end
	

	--keys testing / controllers
	--left
    if love.keyboard.isDown("up") and a.y > map.offset then
		a.y = a.y - 2
    end
    if love.keyboard.isDown("down") and a.y + a.height < map.height + map.offset then
		a.y = a.y + 2
	end
	--right
    if love.keyboard.isDown("w") and b.y > map.offset then
		b.y = b.y - 2
    end
    if love.keyboard.isDown("s") and b.y + b.height < map.height + map.offset then
		b.y = b.y + 2
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

--[[function winner()
	a.score = 3]]

function love.draw()
	--frame and ball
	--change the frame
	love.graphics.rectangle("line", map.offset, map.offset, map.width, map.height, 5, 5, segments)
	love.graphics.circle("fill", ball.x, ball.y, 15)

	--paddles
	--love.graphics.rectangle( mode, x, y, width, height, rx, ry, segments) -syntax
	love.graphics.rectangle("fill", a.x, a.y, a.width, a.height, 5, 5, segments)
	love.graphics.rectangle("fill", b.x, b.y, b.width, b.height, 5, 5, segments)

	love.graphics.setFont(scoreFont)

	--draw score
	--change the font size
	love.graphics.print(a.score, 520, 120)
	love.graphics.print(b.score, 220, 120)
	love.graphics.print("PONG", 350,20)

	--draw line middle
	--change this into dotted line
	love.graphics.line(395, 90, 395, 490)

	--display fps
	--change the color
	love.graphics.print("FPS: "..tostring(love.timer.getFPS( )), 10, 10)
	--displayFPS()
end

--[[function displayFPS()
	love.graphics.print("FPS: "..tostring(love.timer.getFPS( )), 10, 10)
    love.graphics.setColor(0, 255, 0, 255)
end]]


