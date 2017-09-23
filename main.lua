class = require "lib.30log"
lume = require "lib.lume"

Grid = require "grid"
utils = require "utils"
shapes = require "shapes"


function love.load()
    PLAYER_COUNT = 3
    GRID_COLS = 10
    GRID_ROWS = 10
    GRID_SIZE = 48

    SHAPE_ID = 1
    SHAPE = nil

    grid = Grid(100, 100, GRID_COLS, GRID_ROWS, GRID_SIZE)
end


function love.update(dt)

end


function love.draw()
    grid:draw()
end

function love.keypressed(key, scancode, isrepeat)
	SHAPE = key
end
