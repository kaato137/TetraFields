local GameState = State:extend("GameState", {
    -- Player stuff
    players = {},
    currentPlayer = 1,

    -- Shape related things
    shape = nil,
    rotation = 1
})

local DEFAULT_GRID_SIZE = 32

function GameState:init(cols, rows, playerCount, size)
    self.grid = Grid(0, 16, cols, rows, size or DEFAULT_GRID_SIZE)
    self.shape = shapes.getRandomShape()
    self:initPlayers(playerCount)
end


function GameState:update(dt)
    self.grid:update(dt)
end


function GameState:draw()
    local lg = love.graphics

    local sx, sy = self.grid:getShapePos()
    if self.grid:shapeCanBePlaced(sx, sy, self:getShape()) then
        self.grid:projectShape(sx, sy, self:getShape(), COLOR_MAP[self.currentPlayer])
    else
        self.grid:projectShape(sx, sy, self:getShape(), {100, 0, 0})
    end

    self.grid:draw()

    -- Draw player bars
    lg.push()
    for k, v in ipairs(self.players) do
        if k == self.currentPlayer then
            lg.setColor({255, 255, 0})
            lg.print(k .. ': ' .. v, 64 * k + 2, 2)
        end
        lg.setColor(COLOR_MAP[k])
        lg.print(k .. ': ' .. v, 64 * k, 0)
    end
    lg.pop()

end


function GameState:mousemoved(x, y, dx, dy)
    if self.grid:containsPoint(x, y) then
        self.grid:mouseOn(x, y)
    end
end


function GameState:mousepressed(x, y, button)
    -- LEFT MOUSE CLICK
    if button == 'l' or button == 1 then

        local shape = self:getShape()
        local sx, sy = self.grid:getShapePos()

        if not self.grid:shapeCanBePlaced(sx, sy, shape) then
            return
        end

        local scores = self.grid:placeShape(sx, sy, shape, self.currentPlayer)

        for k, v in ipairs(scores) do
            if k == self.currentPlayer then
                self.players[k] = self.players[k] + v
            else
                self.players[k] = self.players[k] - v
            end
        end

        self:nextTurn()

    -- RIGHT MOUSE CLICK
    elseif button == 'r' or button == 2 then
        self:rotateShape()
    end
end


function GameState:initPlayers(count)
    for i = 1, count do
        self.players[i] = 100
    end
end


function GameState.getRandomShape()
    return lume.randomchoice(shapes.codes)
end


function GameState:nextTurn()
    self.shape = shapes.getRandomShape()
    self.currentPlayer = (self.currentPlayer % #self.players) + 1
    self.rotation = 1
end


function GameState:getShape()
    return shapes[self.shape][self.rotation]
end


function GameState:rotateShape()
    self.rotation = (self.rotation % #shapes[self.shape]) + 1
end


return GameState
