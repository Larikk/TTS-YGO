local tableUtil = require("TTS-YGO/src/common/TableUtil")

local module = {}

local COMMON_RARITIES = {
    "Ghost Rare",
    "Secret Rare",
    "Ultimate Rare",
    "Ultra Rare",
    "Super Rare",
    "Rare",
    "Common",
}

local COMMON_RARITIES_SET = tableUtil.toSet(COMMON_RARITIES)

function module.sortRarities(rarities)
    rarities = tableUtil.toSet(rarities)

    -- first come the rarities not listed above
    -- these are usually special ones that do no appear in many releases
    -- afterwards the ones listed above sorted descending
    local sortedRarities = {}

    for rarity, _ in pairs(rarities) do
        if not COMMON_RARITIES_SET[rarity] then
            table.insert(sortedRarities, rarity)
        end
    end

    for _, rarity in ipairs(COMMON_RARITIES) do
        if rarities[rarity] then
            table.insert(sortedRarities, rarity)
        end
    end

    return sortedRarities
end

function module.cardComparator(a, b)
    if a.setCode ~= b.setCode then
        return a.setCode < b.setCode
    else
        return a.rarity < b.rarity
    end
end

return module
