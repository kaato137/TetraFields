local Grid = Object:extend("Grid", {
    x = 0, y = 0,
    cols = 0, rows = 0,
    size = 0,
    width = 0, height = 0,
    selectedPos = {0, 0},
    shapeOffset = 1,
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
    for j = 1, #self.cells do
        for i = 1, #self.cells[j] do
            self.cells[j][i]:update(dt)
        end
    end
end

-- } END UPDATE REGION

-- { RENDER REGION
function Grid:draw()
    local lg = love.graphics

    -- Draw grid
    lg.setColor(10, 100, 200)
    drawGrid(self.x, self.y, self.cols, self.rows, self.size)
    lg.setColor(255, 255, 255)

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


function Grid:projectShape(x, y, shape, color)
    local lg = love.graphics

    lg.setColor(unpack(color))
    for j = 0, 3 do
        for i = 0, 3 do
            if shape[i+j*4 + 1] == 1 then
                lg.rectangle('fill',
                    self.x + (x-1 + i) * self.size,
                    self.y + (y-1 + j) * self.size,
                    self.size, self.size
                )
            end
        end
    end
end

-- } END RENDER REGION


function Grid:mouseOn(x, y)
    local mx, my = self:mouse2pos(x, y)
    self.selectedPos = {mx, my}
end


function Grid:getShapePos()
    local x, y = unpack(self.selectedPos)
    return x - self.shapeOffset, y - self.shapeOffset
end


function Grid:mouse2pos(mx, my)
    local cellOnX = math.floor(math.abs(mx - self.x) / self.size) + 1
    local cellOnY = math.floor(math.abs(my - self.y) / self.size) + 1
    return cellOnX, cellOnY
end


function Grid:shapeCanBePlaced(x, y, shape)
    -- Checks if some of the shape
    -- parts is out of the grid.
    for j = 3, 0, -1 do
        for i = 3, 0, -1 do
            local xx = x + i
            local yy = y + j
            if (shape[i + j * 4 + 1] == 1) and (
               (xx > self.cols) or (yy > self.rows) or
               (xx < 1) or (yy < 1)) then
                return false
            end
        end
    end
    -- Check if shape is collides with other
    for j = 0, 3 do
        for i = 0, 3 do
            if shape[i+j*4 + 1] == 1 and
               not self.cells[y + j][x + i]:empty() then
                return false
            end
        end
    end
    return true
end


function Grid:placeShape(x, y, shape, playerId)
    local red, green, blue = 0, 0, 0
    for j = 0, 3 do
        for i = 0, 3 do
            if shape[i+j*4 + 1] == 1 then
                local cell = self.cells[y + j][x + i]
                cell.owner = playerId
            end
        end
    end
    return red, green, blue
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
