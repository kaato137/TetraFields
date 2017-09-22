local COLOR_MAP = {
    {200, 0, 50},
    {0, 200, 50},
    {50, 0, 200}
}

local Grid = class("Grid", {
    x = 0, y = 0,
    cols = 0, rows = 0,
    size = 0,
    width = 0, height = 0
})


function Grid:init(x, y, cols, rows, size)
    self.x = x or 0
    self.y = y or 0
    self.cols = cols or 10
    self.rows = rows or 10
    self.size = size or 32

    self.content = Grid.generateContent(self.cols, self.rows, 3)

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

    -- Draw grid content
    for j = 1, #self.content do
        for i = 1, #self.content[j] do
            drawCellContent(
                self.x + (i - 1) * self.size,
                self.y + (j - 1) * self.size,
                self.size, self.size,
                self.content[j][i]
            )
        end
    end

    -- Draw mouse position
    local mx = love.mouse.getX()
    local my = love.mouse.getY()
    local text = mx .. ' ' .. my
    lg.print(text, 32, 32)

    if utils.includes(mx, my, self.x, self.y, self.width, self.height) then
        lg.print("INSIDE", 20, 20)
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

function drawCellContent(x, y, w, h, cellContent, bw, bh)
    -- bh and bw stands for ball width and height
    local bw = bw or 4
    local bh = bh or 4
    local lg = love.graphics
    local playersCount = #cellContent

    local rowHeight = h / playersCount

    for pli = 1, playersCount do
        local ballCount = cellContent[pli]
        lg.setColor(COLOR_MAP[pli])
        for bi = 1, ballCount do
            local center = x + (w / 2) - (ballCount * bw * 2) / 2
            lg.circle("fill",
                center + (bi-1) * (bw * 2),
                y + (rowHeight * (pli - 1)) + bh * 2,
                bw, bh
            )
        end
    end
end


function Grid.generateContent(cols, rows, numberOfPlayers)
    local content = {}
    for j = 1, rows do
        content[j] = {}
        for i = 1, cols do
            content[j][i] = Grid.generateCellContent(numberOfPlayers)
        end
    end
    return content
end


function Grid.generateCellContent(numberOfPlayers)
    local cellContent = {}
    local weights = { [1] = 10, [2] = 8, [3] = 4 }
    for i = 1, numberOfPlayers do
        local count = lume.weightedchoice(weights)
        table.insert(cellContent, count)
    end
    return cellContent
end

return Grid