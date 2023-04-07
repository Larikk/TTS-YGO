local module = {}

function module.startsWith(str, pattern)
    local index = string.find(str, pattern, 0, true)
    return index == 1
end

function module.contains(str, pattern)
    local index = string.find(str, pattern, 0, true)
    return index ~= nil
end

function module.endsWith(str, pattern)
    if #str < #pattern then
        return false
    end

    local suffix = string.sub(str, #str - #pattern + 1)

    return suffix == pattern
end

function module.findOccurences(str, pattern)
    if not pattern or pattern == "" then
        return {}
    end

    local indeces = {}
    local i = 0
    local j = 0

    repeat
        i, j = string.find(str, pattern, j + 1, true)
        if j ~= nil then
            table.insert(indeces, i)
        end
    until j == nil

    return indeces
end

function module.split(str, sep)
    -- this function does avoid match-functions on purpose since they are not reliable in TTS and differ between Lua implementations

    -- Seperator at the end is required for this implementation
    str = str .. sep
    local occurencesOfSeperator = module.findOccurences(str, sep)
    local sepLength = #sep

    local parts = {}
    local endOfPreviosSeperator = 0
    for _, i in ipairs(occurencesOfSeperator) do
        local startOfNextSeperator = i
        local part = string.sub(str, endOfPreviosSeperator + 1, startOfNextSeperator - 1)
        table.insert(parts, part)
        endOfPreviosSeperator = startOfNextSeperator + sepLength - 1
    end

    return parts
end

function module.trim(str)
    return (str:gsub("^%s*(.-)%s*$", "%1"))
end

function module.splitByNewLine(str)
    str = string.gsub(str, "\r\n", "\n")
    return module.split(str, "\n")
end

-- returns true if the string consists only of digits
function module.isNumeric(str)
    return str ~= nil and str ~= "" and str:find("%D") == nil
end

function module.stripLeadingCharacter(str, c)
    local pattern = c .. "*(%d+)"
    return str:match(pattern)
end

return module
