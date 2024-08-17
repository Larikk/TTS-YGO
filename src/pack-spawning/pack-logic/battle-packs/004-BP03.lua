local AbstractPackGenerator = require("TTS-YGO/src/pack-spawning/common/AbstractPackGenerator")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local SET_NAME = "Battle Pack 3: Monster League"

local SET_CODE_PREFIX = "BP03-EN"

local SET_NAME_URL = SET_NAME

local PACK_TEXTURES = {
    imageHost .. "/textures/packs/battlepacks/004-BP03A.jpg",
    imageHost .. "/textures/packs/battlepacks/004-BP03B.jpg",
    imageHost .. "/textures/packs/battlepacks/004-BP03C.jpg",
    imageHost .. "/textures/packs/battlepacks/004-BP03D.jpg",
    imageHost .. "/textures/packs/battlepacks/004-BP03E.jpg",
    imageHost .. "/textures/packs/battlepacks/004-BP03F.jpg",
    imageHost .. "/textures/packs/battlepacks/004-BP03G.jpg",
    imageHost .. "/textures/packs/battlepacks/004-BP03H.jpg",
    imageHost .. "/textures/packs/battlepacks/004-BP03I.jpg",
    imageHost .. "/textures/packs/battlepacks/004-BP03J.jpg",
    imageHost .. "/textures/packs/battlepacks/004-BP03K.jpg",
    imageHost .. "/textures/packs/battlepacks/004-BP03L.jpg",
}

local BOX_TEXTURE = imageHost .. "/textures/boxes/battlepacks/003-BP03.png"

local CARDS_IN_PACKS = 5

local PACKS_IN_BOX = 36

-- Rarities
local COMMON = "Common"
local RARE = "Rare"
local SHATTERFOIL_RARE = "Shatterfoil Rare"

-- Ratios for last card, must add up to 1.0
-- values are rounded up
local RATIOS = {}
RATIOS[COMMON] = 0.08
RATIOS[RARE] = 0.24
RATIOS[SHATTERFOIL_RARE] = 0.68


local postListener = function(entries)
    -- Remove the Mosaic rarity from every card that can occur in another rarity
    if #entries > 1 then
        local newEntries = {}
        for i, v in pairs(entries) do
            if v.rarity ~= SHATTERFOIL_RARE then table.insert(newEntries, v) end
        end
        entries = newEntries
    end

    return entries
end


local PackGenerator = AbstractPackGenerator:new()

function PackGenerator:assemblePack()
    local pack = {}

    -- generates one more than needed because the 9th card may or may not be a common
    local commons = self:pullCards(COMMON, 4)
    local rares = self:pullCards(RARE, 2)

    -- 1 rare
    pack[1] = rares[1]

    -- 3 commons
    for i = 2, 4 do
        pack[i] = commons[i-1]
    end

    local f = function(card) card.rarity = string.format("%s (%s)", SHATTERFOIL_RARE, card.rarity) end

    -- last card
    -- any card can be a SHATTERFOIL_RARE
    -- some cards can only be SHATTERFOIL_RARE
    local rarityOfLast = self:pickRarity(RATIOS)
    if rarityOfLast == COMMON then
        pack[5] = commons[4]
        f(pack[5])
    elseif rarityOfLast == RARE then
        pack[5] = rares[2]
        f(pack[5])
    else
        pack[5] = self:pullCard(SHATTERFOIL_RARE)
    end

    return pack
end

function PackGenerator:new()
    local o = AbstractPackGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = SET_NAME
    o.setCodePrefix = SET_CODE_PREFIX
    o.setNameUrl = SET_NAME_URL
    o.cardsInPacks = CARDS_IN_PACKS
    o.packsInBox = PACKS_IN_BOX
    o.packTextures = PACK_TEXTURES
    o.boxTexture = BOX_TEXTURE

    o.setDataExtractor:addPostListener(postListener)

    return o
end

return PackGenerator
