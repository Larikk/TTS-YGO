local guiUtil = require("TTS-YGO/src/gui/GUIUtil")
local state = require("TTS-YGO/src/gui/State")
local cardImport = require("TTS-YGO/src/card-import/CardImporter")

local module = {}

local page = nil

-- IDS of element
local PAGE_ID = "card-import"
local IMPORT_BY_ID_INPUT = PAGE_ID .. ":import-by-id-input"
local IMPORT_BY_ID_BUTTON = PAGE_ID .. ":import-by-id-button"
local IMPORT_BY_NAME_INPUT = PAGE_ID .. ":import-by-name-input"
local IMPORT_BY_NAME_BUTTON = PAGE_ID .. ":import-by-name-button"
local IMPORT_BY_NAME_ARTWORK_TOGGLE = PAGE_ID .. ":import-by-name-artwork-toogle"
local IMPORT_BY_NAME_FUZZY_TOGGLE = PAGE_ID .. ":import-by-name-fuzzy-toogle"



local function createImportById()
    local inputField = {
        tag = "InputField",
        attributes = {
            id = IMPORT_BY_ID_INPUT,
            onValueChanged = "handleInputChange",
            flexibleWidth = "1",
            class = "inputfield"
        }
    }

    local button = guiUtil.createButton(IMPORT_BY_ID_BUTTON, "Import", "green")

    local content = {
        tag = "HorizontalLayout",
        children = {inputField, button}
    }

    return guiUtil.createBox("Spawn by ID/Passcode", "", content)
end

local function createImportByName()
    local inputField = {
        tag = "InputField",
        attributes = {
            id = IMPORT_BY_NAME_INPUT,
            onValueChanged = "handleInputChange",
            flexibleWidth = "1",
            class = "inputfield",
        }
    }

    local artworkToggle = {
        tag = "Toggle",
        value = "Include alternative Artworks",
        attributes = {
            id = IMPORT_BY_NAME_ARTWORK_TOGGLE,
            onValueChanged = "handleInputChange",
            class = "toggle",
            isOn = "false",
            flexibleWidth = "1",
        },
    }

    local fuzzyToggle = {
        tag = "Toggle",
        value = "Fuzzy search instead of exact name (May freeze the game temporarily)",
        attributes = {
            id = IMPORT_BY_NAME_FUZZY_TOGGLE,
            onValueChanged = "handleInputChange",
            class = "toggle",
            isOn = "false",
            flexibleWidth = "1",
            minHeight = "250",
        },
    }

    local button = guiUtil.createButton(IMPORT_BY_NAME_BUTTON, "Import", "green", "MiddleRight")

    local content = {
        tag = "VerticalLayout",
        attributes = {
            spacing = "50"
        },
        children = {inputField, fuzzyToggle, artworkToggle, button}
    }

    return guiUtil.createBox("Spawn by Name", "", content)
end

local function createPageBody()
    return {
        tag = "VerticalLayout",
        attributes = {
            class = "page-body"
        },
        children = {
            createImportById(),
            createImportByName(),
        }
    }
end

local function createPage()
    state.put(IMPORT_BY_NAME_ARTWORK_TOGGLE, "false")
    state.put(IMPORT_BY_NAME_FUZZY_TOGGLE, "false")

    return {
        tag = "VerticalLayout",
        attributes = {
            class = "page"
        },
        children = {
            guiUtil.createNavBar("Import Single Cards"),
            createPageBody(),
        }
    }
end

function module.afterRender()
    local textInputs = {IMPORT_BY_ID_INPUT, IMPORT_BY_NAME_INPUT}
    for _,id in ipairs(textInputs) do
        self.UI.setAttribute(id, "text", state.get(id))
    end

    local id = IMPORT_BY_NAME_ARTWORK_TOGGLE
    self.UI.setAttribute(id, "isOn", state.get(id))
end

local function importById()
    local pos = state.getSpawnPosition()
    local rotation = state.getSpawnRotation()
    local id = state.get(IMPORT_BY_ID_INPUT)
    cardImport.spawnById(id, pos, rotation)
end

local function importByName()
    local pos = state.getSpawnPosition()
    local rotation = state.getSpawnRotation()
    local name = state.get(IMPORT_BY_NAME_INPUT)
    local fuzzy = state.get(IMPORT_BY_NAME_FUZZY_TOGGLE):lower() == "true"
    local allArtworks = state.get(IMPORT_BY_NAME_ARTWORK_TOGGLE):lower() == "true"

    if fuzzy then
        cardImport.spawnByFname(name, allArtworks, pos, rotation)
    else
        cardImport.spawnByName(name, allArtworks, pos, rotation)
    end
end

function module.getPageObject()
    if page == nil then
        module.eventHandlers = {
            [IMPORT_BY_ID_BUTTON] = importById,
            [IMPORT_BY_NAME_BUTTON] = importByName,
        }

        page = createPage()
    end

    return page
end

return module
