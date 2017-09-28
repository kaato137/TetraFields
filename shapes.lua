local shapes = {}

shapes.codes = {'i', 'j', 'l', 'z', 's', 'o', 't'}

shapes['i'] = {
    {
        0,1,0,0,
        0,1,0,0,
        0,1,0,0,
        0,1,0,0
    },
    {
        0,0,0,0,
        1,1,1,1,
        0,0,0,0,
        0,0,0,0
    }
}

shapes['j'] = {
    {
        0,1,0,0,
        0,1,0,0,
        1,1,0,0,
        0,0,0,0
    },
    {
        1,0,0,0,
        1,1,1,1,
        0,0,0,0,
        0,0,0,0,
    },
    {
        0,1,1,0,
        0,1,0,0,
        0,1,0,0,
        0,0,0,0
    },
    {
        0,0,0,0,
        1,1,1,0,
        0,0,1,0,
        0,0,0,0
    }
}

shapes['l'] = {
    {
        0,1,0,0,
        0,1,0,0,
        0,1,1,0,
        0,0,0,0
    },
    {
        0,0,0,0,
        1,1,1,0,
        1,0,0,0,
        0,0,0,0
    },
    {
        1,1,0,0,
        0,1,0,0,
        0,1,0,0,
        0,0,0,0
    },
    {
        0,0,1,0,
        1,1,1,0,
        0,0,0,0,
        0,0,0,0
    }
}

shapes['z'] = {
    {
        0,1,0,0,
        1,1,0,0,
        1,0,0,0,
        0,0,0,0
    },
    {
        1,1,0,0,
        0,1,1,0,
        0,0,0,0,
        0,0,0,0
    }
}

shapes['s'] = {
    {
        1,0,0,0,
        1,1,0,0,
        0,1,0,0,
        0,0,0,0
    },
    {
        0,1,1,0,
        1,1,0,0,
        0,0,0,0,
        0,0,0,0
    }
}

shapes['o'] = {
    {
        0,0,0,0,
        0,1,1,0,
        0,1,1,0,
        0,0,0,0
    }
}

shapes['t'] = {
    {
        0,1,0,0,
        1,1,1,0,
        0,0,0,0,
        0,0,0,0,
    },
    {
        0,1,0,0,
        0,1,1,0,
        0,1,0,0,
        0,0,0,0
    },
    {
        0,0,0,0,
        1,1,1,0,
        0,1,0,0,
        0,0,0,0
    },
    {
        0,1,0,0,
        1,1,0,0,
        0,1,0,0,
        0,0,0,0
    }
}

return shapes
