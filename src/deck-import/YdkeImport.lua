local stringUtil = require("TTS-YGO/src/common/StringUtil")
local mathUtil = require("TTS-YGO/src/common/Math")
local tableUtil = require("TTS-YGO/src/common/TableUtil")
local base64 = require("ge_tts/Base64")
local commonDeckImport = require("TTS-YGO/src/deck-import/CommonDeckImport")


local module = {}

local linkPrefix = "ydke://"

local function convertBytesToCardId(bytes)
    local sum = 0
    for i, byte in ipairs(bytes) do
        sum = sum + mathUtil.lshift(byte, 8 * (i - 1))
    end
    return tostring(math.floor(sum))
end

local function extractCardIdsFromBase64Section(sectionEncodedInBase64)
    if not sectionEncodedInBase64 or sectionEncodedInBase64 == "" then
        return {}
    end

    local bytesOfAllCardIds = base64.decode(sectionEncodedInBase64)
    local numberOfIds = #bytesOfAllCardIds / 4
    local cardIds = {}

    for i = 0, numberOfIds - 1 do
        local start = 1 + 4 * i
        local stop = start + 3
        local bytesOfSingleCardId = tableUtil.subTable(bytesOfAllCardIds, start, stop)
        local cardId = convertBytesToCardId(bytesOfSingleCardId)
        table.insert(cardIds, cardId)
    end

    return cardIds
end

function module.parse(ydkeLink)
    if not stringUtil.startsWith(ydkeLink, linkPrefix) then
        error("YDKe links must start with '" .. linkPrefix .. "'")
    end

    ydkeLink = string.sub(ydkeLink, #linkPrefix + 1)
    local sections = stringUtil.split(ydkeLink, "!")

    local decks = {}

    for i, deckName in ipairs({ "main", "extra", "side" }) do
        local cardIdsOfSingleDeck = extractCardIdsFromBase64Section(sections[i])
        if (#cardIdsOfSingleDeck > 0) then
            decks[deckName] = cardIdsOfSingleDeck
        end
    end

    return decks
end

function module.spawn(ydkeLink, pos, rotation)
    local ran, value = pcall(module.parse, ydkeLink)

    if not ran then
        error("YDKe link could not be parsed: " .. value)
    end

    local decks = value

    commonDeckImport.spawn(decks, pos, rotation)
end

return module
