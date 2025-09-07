local StringBuilder = {}

function StringBuilder:append(s)
    table.insert(self.parts, s)
    return self
end

function StringBuilder:toString()
    return table.concat(self.parts)
end

function StringBuilder:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self

    self.parts = {}

    return o
end

return StringBuilder
