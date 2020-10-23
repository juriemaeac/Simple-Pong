--initialization

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

--sound = love.audio.newSource("pong.wav")

--Font size of the whole game. I recommend to replace this
scoreFont = love.graphics.newFont(30)

function love.update()
	ball.x = ball.x + ball.vel.x
	ball.y = ball.y + ball.vel.y

	--map boundaries
	--right side
	if ball.x >= (map.width + map.offset) - ball.width then
		b.score = b.score + 1
		ball:reset()
	end
	--left side
	if ball.x <= map.offset + (ball.width - 5) then
		a.score = a.score + 1
		ball:reset()
	end

	--walls bounce
	--up
	if ball.y <= map.offset + (ball.width - 5) then
		ball:bounce(1, -1)
	end
	--down
	if ball.y >= (map.height + map.offset) - ball.height then
		ball:bounce(1, -1)
	end

	--paddles bounces
	if ball.x > a.x - 5 and ball.y <= a.y + a.height and ball.y >= a.y - ball.height then
		ball:bounce(-1, 1)
		ball.x = ball.x - 10
	end 
	if ball.x < b.x + 11 and ball.y <= b.y + b.height and ball.y >= b.y - ball.height then
		ball:bounce(-1, 1)
		ball.x = ball.x + 10
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
	--change the font style and size
	love.graphics.print(a.score, 520, 120)
	love.graphics.print(b.score, 220, 120)
	love.graphics.print("PONG", 350,20)

	--draw line middle
	--change this indo dotted line
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


