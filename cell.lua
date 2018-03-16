local Cell = class('Cell', {
    content = {},
    owner = 0
})


function Cell:init(playerCount)
    self.content = Cell.generateCellContent(playerCount)
end


function Cell:draw(x, y, cellWidth, cellHeight, ballWidth, ballHeight)
    -- ballHeight and ballWidth stands for ball width and height
    local ballWidth = ballWidth or 4
    local ballHeight = ballHeight or 4
    local lg = love.graphics
    local playersCount = #self.content

    local rowHeight = cellHeight / playersCount

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
    end

    for pli = 1, playersCount do
        local ballCount = self.content[pli]
        for ballIndex = 1, ballCount do
            local center = x + (cellWidth / 2) - (ballCount * ballWidth * 2) / 2
            local ballX = center + (ballIndex-1) * (ballWidth * 2) + ballWidth
            local ballY = y + (rowHeight * (pli - 1)) + ballHeight * 2

            -- White shadow for ball
            lg.setColor({255, 255, 255})
            lg.circle("fill", ballX + 1, ballY + 1, ballWidth, ballHeight)

            -- The actual ball.
            lg.setColor(COLOR_MAP[pli])
            lg.circle("fill", ballX, ballY, ballWidth, ballHeight)
        end
    end
end


function Cell:empty()
    return self.owner == 0
end


function Cell.generateCellContent(numberOfPlayers)
    local cellContent = {}
    local weights = { [1] = 10, [2] = 8, [3] = 4 }
    for i = 1, numberOfPlayers do
        local count = lume.weightedchoice(weights)
        cellContent[#cellContent+1] = count
    end
    return cellContent
end


return Cell
