local stringUtil = require("TTS-YGO/src/common/StringUtil")
local StringBuilder = require("TTS-YGO/src/common/StringBuilder")

local module = {}

-- create the hover info text of a card
-- the info text includes name, attributes, type, stats etc
-- and is displayed in the name of the object when the player hovers over it

local function linkMonsterText(sb, card)
    sb:append(card.type):append("\n")
    sb:append(card.attribute):append(" "):append(card.race):append("\n")
    sb:append("ATK/"):append(card.atk):append(" LINK-"):append(card.linkval):append("\n")
end

local function monsterText(sb, card)
    local isXYZ = stringUtil.contains(card.type, "XYZ")
    local isPendulum = stringUtil.contains(card.type, "Pendulum")
    local isLink = stringUtil.contains(card.type, "Link")

    if isLink then
        return linkMonsterText(sb, card)
    end

    local starType
    if isXYZ then
        starType = "Rank"
    else
        starType = "Level"
    end

    sb:append(card.type):append("\n")
    sb:append(card.attribute):append(" "):append(card.race)
    sb:append(" ["):append(starType):append(" "):append(card.level):append("]\n")
    sb:append("ATK/"):append(card.atk):append(" DEF/"):append(card.def):append("\n")

    if isPendulum then
        sb:append("Pendulum Scale: "):append(card.scale):append("\n")
    end
end

local function spellTrapText(sb, card)
    if card.race ~= nil then sb:append(card.race):append(" ") end
    sb:append(card.type):append("\n")
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
    local sb = StringBuilder:new()

    local paddedName = padName(card.name)
    sb:append(paddedName):append("\n")

    if card.type == "Trap Card" or card.type == "Spell Card" or card.type == "Skill Card" then
        spellTrapText(sb, card)
    elseif card.type == "Token" then
        sb:append("Token\n")
    else
        monsterText(sb, card)
    end

    if card.rarity ~= nil then
        sb:append(card.rarity):append("\n")
    end

    if card.setCode ~= nil then
        sb:append(card.setCode):append("\n")
    end

    sb:append("\n"):append(card.desc)

    return sb:toString()
end

return module
