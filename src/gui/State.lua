local module = {}

-- persistent settings constants

-- Used in ChatCommandHandler and PackSpawnPage
-- Values: box, cardlist, cardlist-partitioned
local PACK_MODE = "pack:mode"

-- Used in DeckImportPage
-- Values: ydk-file, ydke
local DECK_IMPORT_MODE = "deck-import:mode"

-- same as in SettingsPage.ttslua
local SPAWN_X = "settings:spawn-x"
local SPAWN_Y = "settings:spawn-y"
local SPAWN_Z = "settings:spawn-z"
local SPAWN_ROTATION = "settings:spawn-rotation"
local SPAWN_CARDBACK = "settings:cardback"
local LANGUAGE_SELECTION = "settings:language-selection"

-- stats
local SAVE_ID = "stats:save-id"
local SAVE_ID_CREATION = "stats:save-id-creation"

local persistentValues = {
    PACK_MODE,
    DECK_IMPORT_MODE,
    SPAWN_X,
    SPAWN_Y,
    SPAWN_Z,
    SPAWN_ROTATION,
    SPAWN_CARDBACK,
    LANGUAGE_SELECTION,
    SAVE_ID,
    SAVE_ID_CREATION
}

-- default values
local defaults = {
    -- persistent values, get saved and loaded with the room
    [PACK_MODE] = "box",
    [DECK_IMPORT_MODE] = "ydk-file",
    [SPAWN_X] = "0",
    [SPAWN_Y] = "10",
    [SPAWN_Z] = "0",
    [SPAWN_ROTATION] = "0",
    [SPAWN_CARDBACK] = "",
    [LANGUAGE_SELECTION] = "en",
    [SAVE_ID] = nil,
    [SAVE_ID_CREATION] = nil,
}

-- gets set to defaults on load
local state = {}

function module.getSpawnPosition()
    return Vector(state[SPAWN_X], state[SPAWN_Y], state[SPAWN_Z])
end

function module.getSpawnRotation()
    return Vector(0, state[SPAWN_ROTATION], 0)
end

function module.reset(key)
    state[key] = defaults[key]
end

function module.get(key)
    return state[key]
end

function module.put(key, value)
    state[key] = value
end

function module.save()
    local save = {}

    for _, v in ipairs(persistentValues) do save[v] = state[v] end

    return JSON.encode(save)
end

function module.reset()
    state = {}
    for k, v in pairs(defaults) do state[k] = v end
end

function module.loadFromSave(save)
    module.reset()

    if save == nil or save == "" then return end

    save = JSON.decode(save)
    for _, v in ipairs(persistentValues) do if save[v] then state[v] = save[v] end end
end

return module
