class = require "lib.30log.30log"
lume = require "lib.lume.lume"

Object = require "object"
Cell = require "cell"
Grid = require "grid"
utils = require "utils"
shapes = require "shapes"

COLOR_MAP = {
    { 200, 0, 50 },
    { 0, 200, 50 },
    { 50, 0, 200 }
}


function love.load()
    GRID_COLS = 10
    GRID_ROWS = 10
    GRID_SIZE = 32

    PLAYER_COUNT = 3
    CURRENT_PLAYER = 1
    SHAPE = 'l'
    ROTATION = 1

    g_players = {}
    initPlayers(PLAYER_COUNT)

    grid = Grid(100, 100, GRID_COLS, GRID_ROWS, GRID_SIZE)
end


function love.update(dt)
    grid:update(dt)
end


function love.draw()
    local lg = love.graphics
    grid:draw()
    lg.push()
    for k, v in ipairs(g_players) do
        if k == CURRENT_PLAYER then
            lg.setColor(255, 255, 0)
        else
            lg.setColor(255, 255, 255)
        end
        lg.print(k .. ': ' .. v, 64 * k, 0)
    end
    lg.pop()
end


function love.mousemoved(x, y, dx, dy, istouch)
    if grid:containsPoint(x, y) then
        grid:mouseOn(x, y)
    end
end


function love.mousepressed(x, y, button, istouch)
    print(button)
    if button == 'l' or button == 1 then
        local sx, sy = grid:getShapePos()
        grid:placeShape(sx, sy, shapes[SHAPE][ROTATION], CURRENT_PLAYER)
        nextTurn()
    elseif button == 'r' or button == 2 then
        rotateShape()
    end
end


function nextTurn()
    SHAPE = lume.randomchoice(shapes.codes)
    CURRENT_PLAYER = (CURRENT_PLAYER % PLAYER_COUNT) + 1
    ROTATION = 1
end


function rotateShape()
    ROTATION = (ROTATION % #shapes[SHAPE]) + 1
end


function initPlayers(count)
    for i = 1, count do
        g_players[i] = 100
    end
end
