local Grid = Object:extend("Grid", {
    x = 0, y = 0,
    cols = 0, rows = 0,
    size = 0,
    width = 0, height = 0,
    selectedPos = {0, 0}
})


function Grid:init(x, y, cols, rows, size)
    Grid.super.init(self, x, y)
    self.cols = cols or 10
    self.rows = rows or 10
    self.size = size or 32

    -- Array for
    self.cells = Grid.generateContent(self.cols, self.rows, 3)

    self.width = self.cols * self.size
    self.height = self.rows * self.size
end


function Grid:update(dt)

end


function Grid:draw()
    local lg = love.graphics

    -- Draw grid
    lg.setColor(10, 100, 200)
    drawGrid(self.x, self.y, self.cols, self.rows, self.size)
    lg.setColor(255, 255, 255)

    -- Draw mouse position
    local shape = shapes[SHAPE][ROTATION]

    -- Draw shape projection
    local sx, sy = unpack(self.selectedPos)
    if self:shapeCanBePlaced(sx, sy, shape) then
        lg.setColor(0, 0, 100)
    else
        lg.setColor(100, 0, 0)
    end
    self:projectShapeToGrid(sx - 1, sy - 1, shape)

    -- Draw grid content
    for j = 1, #self.cells do
        for i = 1, #self.cells[j] do
            self.cells[j][i]:draw(
                self.x + (i - 1) * self.size,
                self.y + (j - 1) * self.size,
                self.size, self.size
            )
        end
    end
end


function Grid:mouseOn(x, y)
    local mx, my = self:mouse2pos(x, y)
    self.selectedPos = {mx, my}
end


function Grid:mouse2pos(mx, my)
    local cellOnX = math.floor(math.abs(mx - self.x) / self.size)
    local cellOnY = math.floor(math.abs(my - self.y) / self.size)
    return cellOnX, cellOnY
end


function Grid:projectShapeToGrid(x, y, shape)
    local lg = love.graphics

    -- Harcode fours because i don't think
    -- i would do larger shapes
    for j = 0, 3 do
        for i = 0, 3 do
            if shape[i+j*4 + 1] == 1 then
                lg.rectangle('fill',
                    self.x + (x + i) * self.size,
                    self.y + (y + j) * self.size,
                    self.size, self.size
                )
            end
        end
    end
end


function Grid:shapeCanBePlaced(x, y, shape)
    -- Checks if some of the shape
    -- parts is out of the grid.
    for j = 3, 0, -1 do
        for i = 3, 0, -1 do
            if (x + i > self.cols) or (y + j > self.rows) or
               (x + i <= 0) or (y + j <= 0) then
                return false
            end        
        end
    end
    -- Check if shape is collides with other
    for j = 1, 4 do
        for i = 1, 4 do
            if shape[i+j*4] == 1 and
               not self.cells[y + j][x + i]:empty() then
                return false
            end
        end
    end
    return true
end


function Grid:placeShape(x, y, shape, playerId)
    for j = 1, 4 do
        for i = 1, 4 do
            if shape[i+j*4] == 1 then
                self.cells[y + j][x + i].owner = playerId
            end
        end
    end
end


function drawGrid(ox, oy, cols, rows, size)
    local lg = love.graphics
    for j = 1, rows + 1 do
        for i = 1, cols + 1 do
            -- Draw Vertical line
            local x1 = (i - 1) * size
            local y1 = 0
            local x2 = x1
            local y2 = rows * size
            lg.line(x1 + ox, y1 + oy, x2 + ox, y2 + oy)
            -- Draw horizontal line
            x1 = 0
            y1 = (j - 1) * size
            x2 = cols * size
            y2 = y1
            lg.line(x1 + ox, y1 + oy, x2 + ox, y2 + oy)
        end
    end
end


function Grid.generateContent(cols, rows, numberOfPlayers)
    local cells = {}
    for j = 1, rows do
        cells[j] = {}
        for i = 1, cols do
            cells[j][i] = Cell(numberOfPlayers)
        end
    end
    return cells
end

return Grid
