local TtsSpawner = require("TTS-YGO/src/common/TtsSpawner")
local cardImportCache = require("TTS-YGO/src/common/CardImportCache")

local module = {}

local function getCardsToSpawn(cards, allArtworks)
    if not allArtworks then
        return cards
    end

    local cardsToSpawn = {}

    for _, cardWithMainArtwork in ipairs(cards) do
        table.insert(cardsToSpawn, cardWithMainArtwork)

        for _,id in ipairs(cardWithMainArtwork.otherArtworks) do
            local cardAlternativeArtwork = cardImportCache.getCard(id)
            table.insert(cardsToSpawn, cardAlternativeArtwork)
        end
    end

    return cardsToSpawn
end

function module.spawnById(id, pos, rotation)
    local cb = function()
        local card = cardImportCache.getCard(id)
        local spawner = TtsSpawner:new()
        spawner:spawnCard(card, pos, rotation)
    end

    cardImportCache.ensureCardIsPresent(id, cb)
end

function module.spawnByName(name, allArtworks, pos, rotation)
    local cb = function()
        local cardWithMainArtwork = cardImportCache.getCardByName(name)
        local cardsToSpawn = getCardsToSpawn({cardWithMainArtwork}, allArtworks)

        local spawner = TtsSpawner:new()
        spawner:spawnDeck(cardsToSpawn, pos, rotation)
    end

    cardImportCache.ensureCardIsPresentByName(name, cb)
end

function module.spawnByFname(fname, allArtworks, pos, rotation)
    if string.len(fname) < 3 then
        error("Fuzzy search does not support searches with less than 3 letters because a large search result can freeze the game.")
    end

    local cb = function()
        local cards = cardImportCache.getCardsByFname(fname)
        local cardsToSpawn = getCardsToSpawn(cards, allArtworks)

        local spawner = TtsSpawner:new()
        spawner:spawnDeck(cardsToSpawn, pos, rotation)
    end

    cardImportCache.ensureCardIsPresentByFname(fname, cb)
end

return module
