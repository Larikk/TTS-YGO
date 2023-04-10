local guiUtil = require("TTS-YGO/src/gui/GUIUtil")
local state = require("TTS-YGO/src/gui/State")
local cardImportCache = require("TTS-YGO/src/common/CardImportCache")
local tableUtil = require("TTS-YGO/src/common/TableUtil")


local module = {}

local page = nil

-- IDs of GUI elements
local PAGE_ID = "settings"
local SPAWN_X_INPUT = PAGE_ID .. ":spawn-x"
local SPAWN_Y_INPUT = PAGE_ID .. ":spawn-y"
local SPAWN_Z_INPUT = PAGE_ID .. ":spawn-z"
local SPAWN_ROTATION_INPUT = PAGE_ID .. ":spawn-rotation"
local CARDBACK_INPUT = PAGE_ID .. ":cardback"
local LANGUAGE_SELECTION = PAGE_ID .. ":language-selection"

local inputFields = {
    SPAWN_X_INPUT, SPAWN_Y_INPUT, SPAWN_Z_INPUT, SPAWN_ROTATION_INPUT, CARDBACK_INPUT
}

local LANGUAGES = { "en", "de", "fr", "it", "pt" }

local function setLanguage(option)
    cardImportCache.clear()
    state.put(LANGUAGE_SELECTION, option)
end

local function createPositionSetting()
    local createLabel = function(val)
        return {
            tag = "Text",
            attributes = {
                class = "position-row",
            },
            value = val .. ":"
        }
    end

    local createInput = function(id, val)
        return {
            tag = "InputField",
            attributes = {
                id = id,
                class = "settings-textfield numerical",
                onValueChanged = "handleInputChange"
            },
            value = "0"
        }
    end

    local content = {
        tag = "HorizontalLayout",
        attributes = {
            class = "position-row"
        },
        children = {
            createLabel("x"),
            createInput(SPAWN_X_INPUT, "x"),
            createLabel("y"),
            createInput(SPAWN_Y_INPUT, "y"),
            createLabel("z"),
            createInput(SPAWN_Z_INPUT, "z"),
        }
    }

    local title = "Position"
    local description = "Determines where objects spawn. (0,0,0) is the center of the room."
    return guiUtil.createBox(title, description, content)
end

local function createRotationSetting()
    local spawnRotation = {
        tag = "InputField",
        attributes = {
            id = SPAWN_ROTATION_INPUT,
            class = "settings-textfield numerical",
            onValueChanged = "handleInputChange"
        },
        value = "0"
    }

    local title = "Rotation"
    local description =
    "Determines the orientation the spawned objects are facing. Sensibles values are between 0 and 360."
    return guiUtil.createBox(title, description, spawnRotation)
end

local function createCardbackSetting()
    local cardbackInputfield = {
        tag = "InputField",
        attributes = {
            id = CARDBACK_INPUT,
            class = "settings-textfield",
            onValueChanged = "handleInputChange",
            placeholder = "https://example.com/cardback.png",
        },
        value = "",
    }

    local title = "Custom Cardback"
    local description =
    "Link to an image for a custom cardback. Leave empty for the default one. (Recommendation: Upload your image with the Cloud Manager for optimal availability.)"
    return guiUtil.createBox(title, description, cardbackInputfield)
end

local function createLanguageSetting()
    local options = {}
    for _, language in ipairs(LANGUAGES) do
        table.insert(options, { tag = "Option", value = language, attributes = {} })
    end
    options[1].attributes.selected = { selected = "true" }

    local languageSelection = {
        tag = "Dropdown",
        attributes = {
            id = LANGUAGE_SELECTION,
            class = "dropdown",
            flexibleWidth = "1",
            dropdownHeight = "1000",
            onValueChanged = "handleEvent",
        },
        children = options,
    }

    local title = "Card Tooltip Language (Beta)"
    local description =
    "Changes the language of the tooltip of cards. Some cards are only available in English. Alternative Languages are German (de), French (fr), Italian (it) and Portuguese (pt)."
    return guiUtil.createBox(title, description, languageSelection)
end

local function createAttribution()
    return {
        tag = "Text",
        value = "Made by Larikk",
        attributes = {
            class = "box-title",
            alignment = "MiddleRight",
            flexibleWidth = "1"
        }
    }
end

local function createPageBody()
    return {
        tag = "VerticalScrollView",
        attributes = {
            class = "invisible",
            flexibleHeight = "1",
            flexibleWidth = "1"
        },
        children = {
            {
                tag = "VerticalLayout",
                attributes = {
                    class = "page-body",
                    contentSizeFitter = "vertical"
                },
                children = {
                    createCardbackSetting(),
                    createLanguageSetting(),
                    createPositionSetting(),
                    createRotationSetting(),
                    createAttribution(),
                }
            }
        },
    }
end

local function createPage()
    return {
        tag = "VerticalLayout",
        attributes = {
            class = "page"
        },
        children = {
            guiUtil.createNavBar("Settings"),
            createPageBody(),
        }
    }
end

function module.afterRender()
    for _, id in ipairs(inputFields) do
        self.UI.setAttribute(id, "text", tostring(state.get(id)))
    end

    -- set language dropdown
    local savedLanguage = state.get(LANGUAGE_SELECTION)
    local languageIndex = tableUtil.indexOf(LANGUAGES, savedLanguage) or 1
    self.UI.setAttribute(LANGUAGE_SELECTION, "value", languageIndex - 1)
end

function module.getPageObject()
    if page == nil then
        module.eventHandlers = {
            [LANGUAGE_SELECTION] = setLanguage,
        }

        page = createPage()
    end

    return page
end

return module
