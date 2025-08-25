local tableUtil = require("TTS-YGO/src/common/TableUtil")
local guiUtil = require("TTS-YGO/src/gui/GUIUtil")
local state = require("TTS-YGO/src/gui/State")
local preconstructedDecks = require("TTS-YGO/src/preconstructed-decks/Decks")

local module = {}

local page = nil

local PAGE_ID = "preconstructed-decks"
local SEARCH_INPUT = PAGE_ID .. ":search-field"

local nameCodeMapping = {} -- Mapping from setName:lower to the setCode, used for filtering/searching

local function spawnDeck(code)
    local pos = state.getSpawnPosition()
    local rotation = state.getSpawnRotation()
    preconstructedDecks.spawn(code, pos, rotation)
end

local function hide(filter)
    filter = filter:lower()

    for name, code in pairs(nameCodeMapping) do
        if string.find(name, filter, 0, true) then
            self.UI.show(code)
        else
            self.UI.hide(code)
        end
    end
end

local function showAll()
    for _, code in pairs(nameCodeMapping) do
        self.UI.show(code)
    end
end

local function applyFilter(filter)
    state.put(SEARCH_INPUT, filter)
    if filter == nil or filter == "" then
        showAll()
    else
        hide(filter)
    end
end

local function createDeckButton(deck)
    local id = PAGE_ID .. ":" .. deck.code
    module.eventHandlers[id] = function() spawnDeck(deck.code) end
    nameCodeMapping[deck.name:lower()] = id

    return {
        tag = "Button",
        attributes = {
            id = id,
            class = "pack-button",
            onClick = "handleEvent"
        },
        children = {
            {
                tag = "VerticalLayout",
                attributes = {
                    class = "pack-button"
                },
                children = {
                    {
                        tag = "Image",
                        attributes = {
                            class = "pack-image",
                            flexibleHeight = "1",
                            flexibleWidth = "1",
                            image = deck.code
                        }
                    },
                    {
                        tag = "Text",
                        attributes = {
                            text = deck.name,
                            class = "pack-name",
                            flexibleWidth = "1",
                        }
                    }
                }
            }
        }
    }
end

local function createRandomDeckButton(sectionName, decks)
    sectionName = string.gsub(sectionName, " ", "_")
    local localId = "__random_" .. sectionName
    local globalId = PAGE_ID .. ":" .. localId
    module.eventHandlers[globalId] = function()
        local deck = tableUtil.getRandomElement(decks)
        spawnDeck(deck.code)
    end

    return {
        tag = "Button",
        attributes = {
            id = globalId,
            class = "pack-button",
            onClick = "handleEvent"
        },
        children = {
            {
                tag = "VerticalLayout",
                attributes = {
                    class = "pack-button"
                },
                children = {
                    {
                        tag = "Text",
                        attributes = {
                            text = "?",
                            class = "pack-name",
                            fontSize = "500",
                            flexibleHeight = "1",
                            flexibleWidth = "1",
                        }
                    },
                    {
                        tag = "Text",
                        attributes = {
                            text = "Random Deck",
                            class = "pack-name",
                            flexibleWidth = "1",
                        }
                    }
                }
            }
        }
    }
end

local function createSection(title, buttons)
    return {
        tag = "VerticalLayout",
        attributes = {
            class = "pack-section-container",
            flexibleWidth = "1",
        },
        children = {
            {
                tag = "Text",
                attributes = {
                    class = "pack-section",
                    flexibleWidth = "1",
                    text = title
                }
            },
            {
                tag = "GridLayout",
                attributes = {
                    class = "invisible pack-section",
                    flexibleWidth = "1",
                },
                children = buttons
            }
        }
    }
end

local function createDeckSelectionSection(sectionName, decks)
    local buttons = {}
    for _, deck in ipairs(decks) do
        local button = createDeckButton(deck)
        table.insert(buttons, button)
    end

    local randomDeckButton = createRandomDeckButton(sectionName, decks)
    table.insert(buttons, randomDeckButton)
    return createSection(sectionName, buttons)
end

local function createDeckSelection()
    local children = {}

    -- Starter Decks
    local starterDecks = preconstructedDecks.getStarterDecks()
    local starterDecksSelectionSection = createDeckSelectionSection("Starter Decks", starterDecks)
    table.insert(children, starterDecksSelectionSection)


    -- Structure Decks
    local structureDecks = preconstructedDecks.getStructureDecks()
    local structureDecksSelectionSection = createDeckSelectionSection("Structure Decks", structureDecks)
    table.insert(children, structureDecksSelectionSection)

    return {
        tag = "VerticalScrollView",
        attributes = {
            class = "invisible",
            flexibleHeight = "1",
            flexibleWidth = "1"
        },
        children = {
            tag = "VerticalLayout",
            attributes = {
                contentSizeFitter = "vertical"
            },
            children = children
        }
    }
end

local function createNavBar()
    local title = "Spawn Starter and Structure Decks"

    local searchLabel = {
        tag = "Text",
        attributes = {
            class = "nav-bar search-label"
        },
        value = "Search: ",
    }

    local searchField = {
        tag = "InputField",
        attributes = {
            id = SEARCH_INPUT,
            class = "search-field",
            onValueChanged = "handleEvent"
        }
    }

    local additionalElements = { searchLabel, searchField }

    return guiUtil.createNavBar(title, additionalElements)
end

local function createPage()
    return {
        tag = "VerticalLayout",
        attributes = {
            class = "page"
        },
        children = {
            createNavBar(),
            createDeckSelection()
        },
    }
end

function module.afterRender()
    local filter = state.get(SEARCH_INPUT)
    self.UI.setAttribute(SEARCH_INPUT, "text", filter)
    applyFilter(filter)
end

function module.getPageObject()
    if page == nil then
        module.eventHandlers = {
            -- event handlers for buttons are added somewhere else
            [SEARCH_INPUT] = applyFilter,
        }
        page = createPage()
    end

    return page
end

return module
