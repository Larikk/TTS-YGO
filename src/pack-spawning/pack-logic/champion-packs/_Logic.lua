local AbstractPackGenerator = require("TTS-YGO/src/pack-spawning/common/AbstractPackGenerator")

-- Rarities
local COMMON = "Common"
local RARE = "Rare"
local SUPER_RARE = "Super Rare"
local ULTRA_RARE = "Ultra Rare"

-- Ratios for last card, must add up to 1.0
-- taken from https://www.pojo.biz/board/showthread.php?t=404979
local RATIOS = {}
RATIOS[RARE] = 0.896
RATIOS[SUPER_RARE] = 0.083
RATIOS[ULTRA_RARE] = 0.021


local PackGenerator = AbstractPackGenerator:new()

function PackGenerator:assemblePack()
    local pack = {}


    -- 2 commons
    local commons = self:pullCards(COMMON, 2)
    for i = 1, 2 do
        pack[i] = commons[i]
    end

    -- one rare/holo card
    local rarityOfLast = self:pickRarity(RATIOS)
    pack[3] = self:pullCard(rarityOfLast)

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
