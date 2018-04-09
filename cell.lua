local Cell = class('Cell', {
    content = {},
    owner = 0,
    timer = 0,
})


function Cell:init(playerCount)
    self.content = Cell.generateCellContent(playerCount)
end


function Cell:update(dt)
    self.timer = self.timer + dt * 50
end


function Cell:draw(x, y, cellWidth, cellHeight, ballWidth, ballHeight)
    -- ballHeight and ballWidth stands for ball width and height
    local ballWidth = ballWidth or 4
    local ballHeight = ballHeight or 4
    local lg = love.graphics
    local ballCount = #self.content

    -- Draw owner background
    if self.owner > 0 then
        -- Dim the blackground color a
        -- bit so it don't overlap balls.
        local color = COLOR_MAP[self.owner]
        local backColor = {
            color[1] / 2,
            color[2] / 2,
            color[3] / 2
        }
        lg.setColor(backColor)
        lg.rectangle("fill", x, y, cellWidth, cellHeight)
        return
    end

    for i = 1, ballCount do
        local ball = self.content[i]
        local step = 360 / ballCount

        local centerX = cellWidth / 2 - ballWidth / 2
        local centerY = cellHeight / 2 - ballHeight / 2

        local ballX = x + centerX + math.cos(math.rad(step * (i - 1) - step / 2 + self.timer)) * 8
        local ballY = y + centerY - math.sin(math.rad(step * (i - 1) - step / 2 + self.timer)) * 8

        -- White shadow for ball
        lg.setColor({255, 255, 255})
        lg.circle("fill", ballX + 1, ballY + 1, ballWidth, ballHeight)

        -- The actual ball.
        lg.setColor(COLOR_MAP[ball])
        lg.circle("fill", ballX, ballY, ballWidth, ballHeight)
    end
end


function Cell:empty()
    return self.owner == 0
end


function Cell.generateCellContent()
    local cellContent = {}
    local weights = { [1] = 10, [2] = 8, [3] = 4 }
    local count = lume.weightedchoice(weights)
    for i = 1, count do
        table.insert(cellContent, math.floor(lume.random(1, 4)))
    end
    return cellContent
end


return Cell
