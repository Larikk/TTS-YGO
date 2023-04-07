local cardImportCache = require("TTS-YGO/src/common/CardImportCache")
local io = require("TTS-YGO/src/common/IO")
local TtsSpawner = require("TTS-YGO/src/common/TtsSpawner")

local module = {}

local function mapIdsToCards(ids)
    local cards = {}

    for _, id in ipairs(ids) do
        local card = cardImportCache.getCard(id)
        if card ~= nil then
            table.insert(cards, card)
        end
    end

    return cards
end

--[[
    Structure of decks: {
        main: { 1, 2, 3 },
        extra: { 4, 5, 6 },
        side: { 7, 8, 9 }
    }
]]
function module.spawn(decks, pos, rotation)
    local cardIds = {}

    for _, deck in pairs(decks) do
        for _, id in ipairs(deck) do
            table.insert(cardIds, id)
        end
    end

    local cb = function()
        --executed after cache was populated
        local spawnPositions = {
            main = pos,
            extra = pos + Vector(-5, 0, 0),
            side = pos + Vector(5, 0, 0),
        }

        local spawner = TtsSpawner:new()
        for deckName, pos in pairs(spawnPositions) do
            local deck = decks[deckName]
            if deck ~= nil and #deck > 0 then
                io.info("Spawning " .. deckName .. " deck...")
                local onSuccess = function() io.success("Finished " .. deckName .. " deck!") end
                deck = mapIdsToCards(deck)
                spawner:spawnDeck(deck, pos, rotation, onSuccess)
            end
        end
    end

    cardImportCache.ensureCardsArePresent(cardIds, cb)
end

return module
