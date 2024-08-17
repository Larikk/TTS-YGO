local tableUtil = require("TTS-YGO/src/common/TableUtil")

local function e(s)
    broadcastToAll(s, { r = 1, g = 0, b = 0 })
end

local function s(value)
    if type(value) == "table" then
        return tableUtil.serializeTable(value)
    end

    return tostring(value)
end

local function areKeysEqual(a, b)
    if #a ~= #b then return false end
    for i, e in ipairs(a) do
        if e ~= b[i] then return false end
    end
    return true
end

local function areEqual(a, b)
    if type(a) ~= type(b) then
        return false
    end

    if type(a) == "table" then
        local aKeys = tableUtil.keys(a)
        local bKeys = tableUtil.keys(b)
        if not (areKeysEqual(aKeys, bKeys)) then
            return false
        end

        for key, _ in pairs(a) do
            if not areEqual(a[key], b[key]) then
                return false
            end
        end

        return true
    end

    return a == b
end

local function assertEquals(tag, expected, f, ...)
    local ok, result = pcall(f, ...)
    if not ok then
        e("[ERROR] [" .. tag .. "] Expected " .. s(expected) .. ", got error: " .. result)
    end

    if not areEqual(expected, result) then
        e("[ERROR] [" .. tag .. "] Expected " .. s(expected) .. ", got " .. s(result) .. ".")
    end
end

return assertEquals
