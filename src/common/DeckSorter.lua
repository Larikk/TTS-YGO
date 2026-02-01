local tableUtil = require("TTS-YGO/src/common/TableUtil")

local module = {}

local function cardByNameComparator(a, b)
    return a.Nickname < b.Nickname
end

function module.sortDeck(deckObject)
    local deckData = deckObject.getData()

    local cardDatas = tableUtil.copy(deckData.ContainedObjects)
    table.sort(cardDatas, cardByNameComparator)

    deckData.DeckIDs = {}
    deckData.CustomDeck = {}
    deckData.ContainedObjects = {}

    for i, cardData in ipairs(cardDatas) do
        local customDeckId = cardData.CardID / 100

        deckData.DeckIDs[i] = customDeckId * 100

        local customDeckEntry = cardData.CustomDeck[customDeckId]

        deckData.CustomDeck[customDeckId] = customDeckEntry
        deckData.ContainedObjects[i] = cardData
        deckData.ContainedObjects[i].CustomDeck = {
            [customDeckId] = customDeckEntry
        }
    end

    destroyObject(deckObject)
    Wait.frames(function() spawnObjectData({ data = deckData }) end, 2)
end

return module
