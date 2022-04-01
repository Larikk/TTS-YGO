local module = {}

function module.convertUnicodeSequences(str)
    local pattern = [[\u[0-9a-fA-F]+]]
    local f = function(s) return string.sub(s, 1, 2) .. "{" .. string.sub(s, 3, 6) .. "}" .. string.sub(s, 7) end
    return string.gsub(str, pattern, f)
end

function module.decode(str)
    str = module.convertUnicodeSequences(str)
    return json.parse(str)
end

function module.encode(tbl)
    return json.serialize(tbl)
end

return module
