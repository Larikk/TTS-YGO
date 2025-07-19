local mainXml = require("TTS-YGO/src/gui/MainXml")
local guiUtil = require("TTS-YGO/src/gui/GUIUtil")
local stringUtil = require("TTS-YGO/src/common/StringUtil")
local state = require("TTS-YGO/src/gui/State")
local assets = require("TTS-YGO/src/gui/Assets")
local chatCommandHandler = require("TTS-YGO/src/gui/ChatCommandHandler")
local stats = require("TTS-YGO/src/gui/Stats")

local packSpawnPage = require("TTS-YGO/src/gui/pages/PackSpawnPage")
local preconstructedDecksPage = require("TTS-YGO/src/gui/pages/PreconstructedDecksPage")
local cardImportPage = require("TTS-YGO/src/gui/pages/CardImportPage")
local deckImportPage = require("TTS-YGO/src/gui/pages/DeckImportPage")
local settingsPage = require("TTS-YGO/src/gui/pages/SettingsPage")


local pages = {
    ["packs"] = packSpawnPage,
    ["preconstructed-decks"] = preconstructedDecksPage,
    ["card-import"] = cardImportPage,
    ["deck-import"] = deckImportPage,
    ["settings"] = settingsPage,
}

function switchPage(_, _, id)
    -- Check if the page exists first
    local page = pages[id]

    if not page then error("Page " .. id .. " does not exist") end

    local pageObject = page.getPageObject()

    if not pageObject then error("Page " .. id .. " was not created properly") end

    local xmlTable = self.UI.getXmlTable()

    -- Enable all buttons to ensure they're never stuck in a non-interactable state after switching pages
    for buttonId, _ in pairs(pages) do
        local button = guiUtil.getElementById(buttonId, xmlTable)
        button.attributes.interactable = "true"
    end

    -- Disable pressed button
    local pressedButton = guiUtil.getElementById(id, xmlTable)
    pressedButton.attributes.interactable = "false"

    -- Update UI
    local pageContainer = guiUtil.getElementById("page-container", xmlTable)
    pageContainer.children = pageObject

    self.UI.setXmlTable(xmlTable)
    if type(page.afterRender) == "function" then
        Wait.frames(function() page.afterRender() end, 2)
    end
end

-- Stores content of input fields into state
-- Contents is used for logic and to restore a page on page switch
function handleInputChange(play, value, id)
    state.put(id, value)
end

function handleEvent(player, value, id)
    local pageId = stringUtil.split(id, ":")[1]
    local page = pages[pageId]

    if not page then error("Page " .. pageId .. " does not exist") end

    local handler = page.eventHandlers[id]
    if not handler then error("Handler for " .. id .. " does not exist") end
    handler(value, player)
end

function onChat(msg, sender)
    chatCommandHandler.handle(msg, sender)
end

function onSave()
    return state.save()
end

function onLoad(saveState)
    state.loadFromSave(saveState)
    assets.initAssets()
    self.UI.setXml(mainXml)

    local cond = function() return not self.UI.loading end
    local func = function() switchPage(nil, nil, "packs") end
    Wait.frames(function() Wait.condition(func, cond, 240) end, 5)

    stats.load()
end
