local Object = class("Object", {
    x = 0, y = 0, width = 0, height = 0
})


function Object:init(x, y, width, height)
    self.x = x or 0
    self.y = y or 0
    self.width = width or 0
    self.height = height or 0
end


function Object:containsPoint(x, y)
    return utils.includes(x, y, self.x, self.y,
                          self.width - 1, self.height - 1)
end


return Object
