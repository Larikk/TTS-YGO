local stringUtil = require("TTS-YGO/src/common/StringUtil")
local state = require("TTS-YGO/src/gui/State")
local io = require("TTS-YGO/src/common/IO")

local module = {}

local PREFIX = "!ygo-tts" .. " "

local PACK_MODE = "pack:mode"

local function info(msg)
    io.success("YGO TTS: " .. msg)
end

local function err(msg)
    error("YGO TTS: " .. msg .. "\nType '!ygo-tts help' for a list of available commands.")
end

local function setPackSpawnMode(args)
    if #args < 1 then
        err("No pack mode specified. Valid values: box, cardlist, cardlist-partitioned")
    end

    local mode = args[1]

    if mode == "box" or mode == "cardlist" or mode == "cardlist-partitioned" then
        state.put(PACK_MODE, mode)
        info("Pack mode is set to " .. mode)
    else
        err("Invalid pack mode '" .. mode .. "'. Valid values: box, cardlist, cardlist-partitioned")
    end
end

local function resetSettings()
    state.reset()
    info("Settings were resetted")
end

local function help()
    local f = function(msg)
        printToAll(msg, Color.Teal)
    end

    f("Available commands for Yu-Gi-Oh! TTS Edition:")
    f("!ygo-tts help: Print this message")
    f("!ygo-tts pack-mode [box|cardlist|cardlist-partitioned]: Spawn a copy of each card instead of packs/box. Default: box")
    f("!ygo-tts reset: Reset the settings")
end

local handlers = {
    ["help"] = help,
    ["pack-mode"] = setPackSpawnMode,
    ["reset"] = resetSettings,
}

function module.handle(msg, sender)
    if not stringUtil.startsWith(msg, PREFIX) then
        return
    end

    local msgParts = stringUtil.split(msg, " ")
    table.remove(msgParts, 1) -- remove prefix

    if #msgParts == 0 then
        err("No command specified.")
    end

    local command = msgParts[1]
    table.remove(msgParts, 1)
    local handler = handlers[command]

    if not handler then
        err("Unrecognized command: " .. command)
    end

    handler(msgParts)
end

return module
