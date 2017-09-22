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

    self.width = self.cols * self.size
    self.height = self.rows * self.size
end


function Grid:update(dt)

end


function Grid:draw()
    local lg = love.graphics

    lg.setColor(10, 100, 200)
    drawGrid(self.x, self.y, self.cols, self.rows, self.size)
    lg.setColor(255, 255, 255)
    drawGrid(self.x+2, self.y+2, self.cols, self.rows, self.size)

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

return Grid