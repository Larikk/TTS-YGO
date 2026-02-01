local module = {}

module.packLuaScript = [[
function filterObjectEnter(o)
    return false
end

function onObjectLeaveContainer(container, object)
    if self ~= container then return end

    local rotation = container.getRotation()
    rotation = Vector(0, rotation.y, 0)
    object.setRotation(rotation)

    if self.getQuantity() < 1 then
        self.destruct()
    end
end
]]

module.boxLuaScript = [[
----------------------------------------------
-- General Container Code
----------------------------------------------

function filterObjectEnter(o)
    return false
end

function onObjectLeaveContainer(container, object)
    if self ~= container then return end

    local rotation = container.getRotation()
    rotation = Vector(0, rotation.y, 0)
    object.setRotation(rotation)

    if self.getQuantity() < 1 then
        self.destruct()
    end
end

----------------------------------------------
-- UI
----------------------------------------------

local OPEN_BUTTON_ID = "open-button"
local CONFIRM_BUTTON_ID = "confirm-button"
local CANCEL_BUTTON_ID = "cancel-button"

function onLoad()
    displayOpenButton()
end

function clickHandler(player, value, id)
    if id == OPEN_BUTTON_ID then
        displayConfirmationButtons()
    elseif id == CANCEL_BUTTON_ID then
        displayOpenButton()
    elseif id == CONFIRM_BUTTON_ID then
        bulkOpenPacks()
    end
end

function displayOpenButton()
    local container = getButtonContainer()
    container[1].children = {
        {
            tag = "Button",
            attributes = {
                id = OPEN_BUTTON_ID,
                onClick = "clickHandler()",
                text = "Bulk Open",
                fontSize = 30,
                color = "#2980b9",
                textColor = "White",
            }
        }
    }
    Wait.frames(function() self.UI.setXmlTable(container) end, 5)
end

function displayConfirmationButtons()
    local container = getButtonContainer()
    container[1].children = {
        {
            tag = "Button",
            attributes = {
                id = CONFIRM_BUTTON_ID,
                onClick = "clickHandler()",
                text = "Confirm",
                fontSize = 30,
                color = "#27ae60",
                textColor = "White",
            }
        },
        {
            tag = "Button",
            attributes = {
                id = CANCEL_BUTTON_ID,
                onClick = "clickHandler()",
                text = "Cancel",
                fontSize = 30,
                color = "#c0392b",
                textColor = "White",
            }
        }
    }
    Wait.frames(function() self.UI.setXmlTable(container) end, 5)
end

function getButtonContainer()
    return {
        {
            tag = "HorizontalLayout",
            attributes = {
                position = "-301 0 -150",
                rotation = "180 270 90",
                height = 80,
                width = 380,
                spacing = 20,
            }
        }
    }
end

----------------------------------------------
-- Pack Opening
----------------------------------------------

function bulkOpenPacks()
    local cards = getCards()
    cards = sortedCards(cards)
    local deckData = createDeckData(cards)
    spawnDeck(deckData)
    destroyObject(self)
end

function getCards()
    local boxData = self.getData()
    local packs = boxData.ContainedObjects

    local cards = {}

    for _, pack in ipairs(packs) do
        for _, cardData in ipairs(pack.ContainedObjects) do
            table.insert(cards, cardData)
        end
    end

    return cards
end

function createDeckData(cards)
    local data = {
        Name = "Deck",
        Transform = {
            posX = 0,
            posY = 3,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0,
            scaleX = 1,
            scaleY = 1,
            scaleZ = 1,
        },
        DeckIDs = {},          -- integers: 1000, 800, 600, 400, 200
        CustomDeck = {},       -- objects with FaceURL and BackURL; Index: 10, 8, 6, 4, 2
        ContainedObjects = {}, -- objects with Nickname (string) and CardID (see DeckIDS): 1, 2, 3...
    }

    for i, cardData in ipairs(cards) do
        local customDeckId = cardData.CardID / 100

        data.DeckIDs[i] = customDeckId * 100

        local customDeckEntry = cardData.CustomDeck[customDeckId]

        data.CustomDeck[customDeckId] = customDeckEntry
        data.ContainedObjects[i] = cardData
        data.ContainedObjects[i].CustomDeck = {
            [customDeckId] = customDeckEntry
        }
    end

    return data
end

function spawnDeck(deckData)
    local position = self.getPosition() + Vector(0, 3, 0)
    local rotation = self.getRotation()
    rotation:setAt("z", 180)
    spawnObjectData({
        data = deckData,
        position = position,
        rotation = rotation,
    })
end

function sortedCards(cards)
    local cardsWithMetadata = {}

    for i, card in ipairs(cards) do
        cardsWithMetadata[i] = {
            metadata = json.parse(card.Memo),
            ttsData = card,
        }
    end

    local rarityToRank = determineRarityOrder(cardsWithMetadata)

    local function comparator(a, b)
        if rarityToRank[a.metadata.rarity] ~= rarityToRank[b.metadata.rarity] then
            return rarityToRank[a.metadata.rarity] < rarityToRank[b.metadata.rarity]
        else
            return a.metadata.name < b.metadata.name
        end
    end

    table.sort(cardsWithMetadata, comparator)

    local sortedCards = {}
    for i, cardWithMetadata in ipairs(cardsWithMetadata) do
        sortedCards[i] = cardWithMetadata.ttsData
    end

    return sortedCards
end

function determineRarityOrder(cardsWithMetadata)
    local uniqueRarities = {}
    for _, cardWithMetadata in ipairs(cardsWithMetadata) do
        local rarity = cardWithMetadata.metadata.rarity
        uniqueRarities[rarity] = true
    end

    local commonlyUsedRarities = {
        "Ghost Rare",
        "Secret Rare",
        "Ultimate Rare",
        "Ultra Rare",
        "Super Rare",
        "Rare",
        "Common",
    }

    local commonlyUsedRaritiesAsSet = {}
    for _, rarity in ipairs(commonlyUsedRarities) do
        commonlyUsedRaritiesAsSet[rarity] = true
    end

    local rarityToRank = {}
    local rarityRank = 1

    for rarity, _ in pairs(uniqueRarities) do
        if not commonlyUsedRaritiesAsSet[rarity] then
            rarityToRank[rarity] = rarityRank
            rarityRank = rarityRank + 1
        end
    end

    for _, rarity in ipairs(commonlyUsedRarities) do
        rarityToRank[rarity] = rarityRank
        rarityRank = rarityRank + 1
    end

    return rarityToRank
end
]]

return module
