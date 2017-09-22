class = require "lib.30log"
lume = require "lib.lume"

Grid = require "grid"
utils = require "utils"

function love.load()
    PLAYER_COUNT = 3
    GRID_COLS = 10
    GRID_ROWS = 10
    GRID_SIZE = 48

    grid = Grid(100, 100, GRID_COLS, GRID_ROWS, GRID_SIZE)
end


function love.update(dt)

end


function love.draw()
    grid:draw()
end
