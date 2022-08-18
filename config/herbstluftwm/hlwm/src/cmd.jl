function _cmdjoin(x)
    return `$(x)`
end

function _cmdjoin(x, y)
    return `$(x) $(y)`
end

function _cmdjoin(x...)
    return reduce(_cmdjoin, [x...])
end

function cmd(s)
    return _cmdjoin(split(s, " ")...)
end

