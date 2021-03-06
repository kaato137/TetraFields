class = require "lib.30log.30log"
lume = require "lib.lume.lume"

Object = require "object"
Cell = require "cell"
Grid = require "grid"
utils = require "utils"
shapes = require "shapes"

State = require "state"
GameState = require "gamestate"

COLOR_MAP = {
    { 200, 0, 50 },
    { 0, 200, 50 },
    { 50, 0, 200 }
}


function love.load()
    -- LOAD AND SET CUSTOM IMAGE FONT
	font = love.graphics.newImageFont(
        "res/Imagefont.png",
        " abcdefghijklmnopqrstuvwxyz" ..
        "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
        "123456789.,!?-+/():;%&`'*#=[]\"")

	love.graphics.setFont(font)
    currentState = GameState(10, 10, 3)
end


function love.update(dt)
    currentState:update(dt)
end


function love.draw()
    currentState:draw()
end


function love.mousemoved(x, y, dx, dy, istouch)
    currentState:mousemoved(x, y, dx, dy)
end


function love.mousepressed(x, y, button, istouch)
    currentState:mousepressed(x, y, button)
end
