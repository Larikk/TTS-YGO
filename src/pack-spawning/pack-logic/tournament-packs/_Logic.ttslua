local AbstractPackGenerator = require("TTS-YGO/src/pack-spawning/common/AbstractPackGenerator")

-- Rarities
local COMMON = "Common"
local RARE = "Rare"
local SUPER_RARE = "Super Rare"
local ULTRA_RARE = "Ultra Rare"

-- Ratios for last card, must add up to 1.0
-- taken from https://youtu.be/Q-H7nckT6fU?t=101
local RATIOS = {}
RATIOS[COMMON] = 0.60
RATIOS[RARE] = 0.33
RATIOS[SUPER_RARE] = 0.06
RATIOS[ULTRA_RARE] = 0.01


local PackGenerator = AbstractPackGenerator:new()

function PackGenerator:assemblePack()
    local pack = {}

    -- all three cards can be commons
    local commons = self:pullCards(COMMON, 3)

    -- 2 commons
    for i = 1, 2 do
        pack[i] = commons[i]
    end

    -- one card which can have any rarity
    local rarityOfLast = self:pickRarity(RATIOS)
    if rarityOfLast == COMMON then
        pack[3] = commons[3]
    else
        pack[3] = self:pullCard(rarityOfLast)
    end

    return pack
end

function PackGenerator:new()
    local o = AbstractPackGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = nil
    o.setCodePrefix = nil
    o.setNameUrl = nil
    o.cardsInPacks = 3
    o.packsInBox = 1
    o.packTextures = nil
    o.releaseDate = nil

    return o
end

return PackGenerator
