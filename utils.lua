local utils = {}


function utils.includes(x, y, ax, ay, aw, ah)
    return (x >= ax and x <= ax + aw) and
           (y >= ay and y <= ay + ah)
end


return utils