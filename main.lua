class = require "lib.30log"
lume = require "lib.lume"

Cell = require "cell"
Grid = require "grid"
utils = require "utils"
shapes = require "shapes"

COLOR_MAP = {
    {200, 0, 50},
    {0, 200, 50},
    {50, 0, 200}
}


function love.load()
    GRID_COLS = 15
    GRID_ROWS = 15
    GRID_SIZE = 32

    PLAYER_COUNT = 3
    CURRENT_PLAYER = 1
    SHAPE = 'l'
    ROTATION = 1

    grid = Grid(100, 100, GRID_COLS, GRID_ROWS, GRID_SIZE)
end


function love.update(dt)

end


function love.draw()
    grid:draw()
end


function love.keypressed(key, scancode, isrepeat)
    if key == 'left' or key == 'right' then
        ROTATION = (ROTATION % #shapes[SHAPE]) + 1
    end
end


function love.mousepressed(x, y, button, istouch)
    if button == 'l' then
        local mx, my = grid:mouse2pos()
        grid:placeShape(mx - 1, my - 1, shapes[SHAPE][ROTATION], CURRENT_PLAYER)
        nextTurn()
    end
end


function nextTurn()
    SHAPE = lume.randomchoice(shapes.shapes)
    CURRENT_PLAYER = (CURRENT_PLAYER % PLAYER_COUNT) + 1
    ROTATION = 1
end