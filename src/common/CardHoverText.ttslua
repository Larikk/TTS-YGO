local stringUtil = require("TTS-YGO/src/common/StringUtil")

local module = {}

-- create the hover info text of a card
-- the info text includes name, attributes, type, stats etc
-- and is displayed in the name of the object when the player hovers over it

local function linkMonsterText(card)
    local str = card.type .. "\n"
    str = str .. card.attribute .. " " .. card.race .. "\n"
    str = str .. "ATK/" .. card.atk
    str = str .. " LINK-" .. card.linkval .. "\n"

    return str
end

local function monsterText(card)
    local isXYZ = stringUtil.contains(card.type, "XYZ")
    local isPendulum = stringUtil.contains(card.type, "Pendulum")
    local isLink = stringUtil.contains(card.type, "Link")

    if isLink then
        return linkMonsterText(card)
    end

    local starType = isXYZ and "Rank" or "Level"

    local str = card.type .. "\n"
    str = str .. string.format("%s %s [%s %d]\n", card.attribute, card.race, starType, card.level)
    str = str .. "ATK/" .. card.atk
    str = str .. " DEF/" .. card.def .. "\n"

    if isPendulum then
        str = str .. "Pendulum Scale: " .. card.scale .. "\n"
    end

    return str
end

local function spellTrapText(card)
    local str = ""

    if card.race ~= nil then str = str .. card.race .. " " end

    str = str .. card.type .. "\n"

    return str
end

-- When using the search window for a deck the tooltip with the TTS name (which includes card name and effect here)
-- is only displayed if the first line of the TTS name does not fit into the UI.
-- This function pads the first line with spaces to force the tooltip to display.
local function padName(name)
    local targetLength = 20
    local nameLength = string.len(name)
    local delta = targetLength - nameLength

    if delta > 0 then
        name = name .. string.rep(" ", delta)
    end

    return name
end

function module.create(card)
    local result = padName(card.name) .. "\n"

    if card.type == "Trap Card" or card.type == "Spell Card" or card.type == "Skill Card" then
        result = result .. spellTrapText(card)
    else
        result = result .. monsterText(card)
    end

    if card.rarity ~= nil then
        result = result .. card.rarity .. "\n"
    end

    if card.setCode ~= nil then
        result = result .. card.setCode .. "\n"
    end

    result = result .. "\n" .. card.desc

    return result
end

return module
