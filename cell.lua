local Cell = class('Cell', {
    content = {},
    owner = 0
})


function Cell:init(playerCount)
    self.content = Cell.generateCellContent(playerCount)
end


function Cell:draw(x, y, w, h, bw, bh)
    -- bh and bw stands for ball width and height
    local bw = bw or 4
    local bh = bh or 4
    local lg = love.graphics
    local playersCount = #self.content

    local rowHeight = h / playersCount

    lg.print(self.owner, x, y)
    -- Draw owner background
    if self.owner > 0 then
        lg.setColor(COLOR_MAP[self.owner])
        lg.rectangle("fill", x, y, w, h)
    end    

    for pli = 1, playersCount do
        local ballCount = self.content[pli]
        lg.setColor(COLOR_MAP[pli])
        for bi = 1, ballCount do
            local center = x + (w / 2) - (ballCount * bw * 2) / 2
            lg.circle("fill",
                center + (bi-1) * (bw * 2) + bw,
                y + (rowHeight * (pli - 1)) + bh * 2,
                bw, bh
            )
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
