local io = require("TTS-YGO/src/common/IO")
local stringUtil = require("TTS-YGO/src/common/StringUtil")

SetDataExtractor = {}

local function isSetCodeMatching(cardCode, prefixes)
    for _, prefix in ipairs(prefixes) do
        if stringUtil.startsWith(cardCode, prefix) then
            return true
        end
    end
    return false
end

-- extracts all available rarities and other set related data
function SetDataExtractor:extract(cardApiData, name, codePrefixes)
    if (type(codePrefixes) == "string") then
        codePrefixes = { codePrefixes }
    end

    local entries = {}

    for _, set in ipairs(cardApiData.card_sets) do
        if set.set_name == name and isSetCodeMatching(set.set_code, codePrefixes) then
            local rarity = self.replacements[set.set_rarity] or set.set_rarity -- replace if necessary
            if not self.ignoreList[rarity] then                                -- only add if the rarity is not ignored
                local entry = {}
                entry.rarity = rarity
                entry.setCode = set.set_code
                table.insert(entries, entry)
            end
        end
    end

    for i, v in pairs(self.postListeners) do entries = v(entries) end

    if #entries == 0 then
        io.warning(string.format("Warning: Could not extract rarity/setcode of %s. It may be that this card won't be in the card pool.", cardApiData.name))
    end

    return entries
end

-- init methods
function SetDataExtractor:replace(replacements)
    self.replacements = replacements
    return self
end

function SetDataExtractor:ignore(...)
    local list = {}
    for i, v in ipairs({ ... }) do
        list[v] = true
    end
    self.ignoreList = list
    return self
end

function SetDataExtractor:addPostListener(listener)
    if (type(listener) == "function") then
        table.insert(self.postListeners, listener)
    else
        io.error(listener .. " is not a function.")
    end

    return self
end

-- Constructor
function SetDataExtractor:new(o)
    local o = o or {}
    setmetatable(o, self)
    self.__index = self

    o.setName = nil
    o.setCodePrefix = nil

    o.replacements = {}
    o.ignoreList = {}

    o.postListeners = {}

    return o
end

return SetDataExtractor
