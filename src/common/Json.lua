local module = {}


local function temporaryHackyWorkaroundForNegativeNumbers(str)
    str = string.gsub(str, [["atk":%-1]], [["atk":0]])
    str = string.gsub(str, [["def":%-1]], [["def":0]])
    return str
end


function module.convertUnicodeSequences(str)
    local pattern = [[\u[0-9a-fA-F]+]]
    local f = function(s) return string.sub(s, 1, 2) .. "{" .. string.sub(s, 3, 6) .. "}" .. string.sub(s, 7) end
    return string.gsub(str, pattern, f)
end

function module.decode(str)
    str = module.convertUnicodeSequences(str)
    str = temporaryHackyWorkaroundForNegativeNumbers(str)
    return json.parse(str)
end

function module.encode(tbl)
    return json.serialize(tbl)
end

return module
