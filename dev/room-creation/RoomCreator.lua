-- require("TTS-YGO/dev/room-creation/RoomCreator").create8p()
-- require("TTS-YGO/dev/room-creation/RoomCreator").create2p()

local draftTable = require("TTS-YGO/dev/room-creation/draft-table/DraftTableCreator")
local playTable = require("TTS-YGO/dev/room-creation/play-table/PlayTableCreator")
local playTable2p = require("TTS-YGO/dev/room-creation/play-table/PlayTableCreator2Player")
local util = require("TTS-YGO/dev/room-creation/Util")

local POS = Vector(13.5, 2, 0)
local ROTATION = Vector(0, 90, 0)

local module = {}

local function spawnStuff8p()
    local pos = POS + Vector(0, 0, -100)
    local rotation = ROTATION
    draftTable.create(pos, rotation)

    pos = pos + Vector(150, 0, -96)
    rotation = rotation + Vector(0, 180, 0)
    local colors = util.getPlayerColors()

    for i = 1, 4 do
        local temp = pos:copy()
        Wait.time(function() playTable.create(temp, rotation, colors[i], colors[i + 4]) end, 3)
        pos = pos + Vector(0, 0, 64)
    end
end

local function spawnStuff2p()
    local pos = Vector(0, 0, 0)
    local rotation = Vector(0, 0, 0)
    local colors = { "Blue", "Red" }

    playTable2p.create(pos, rotation, "Blue", "Red")
end

local function common()
    -- Info section
    Info.name = "Yu-Gi-Oh! TTS Edition"
    Info.type = "Game"
    Info.complexity = "Medium Complexity"
    Info.tags = {
        "Cards",
        "Scripting",
        "User Interfaces",
        "Yu-Gi-Oh",
        "Yu-Gi-Oh!",
        "YuGiOh",
        "YuGiOh!",
        "deck",
        "build",
        "progressive",
        "sealed",
        "draft",
        "importer",
        "ydk",
        "starter deck",
        "structure deck",
    }

    Tables.setTable("None")
    Backgrounds.setBackground("Museum")
    Wait.time(
        function() Backgrounds.setCustomURL("http://cloud-3.steamusercontent.com/ugc/1804229846320834487/463F17DD295878A1FA27B4825CC3496905BC5E13/") end,
        2
    )

    Lighting.light_intensity = 0.7
    Lighting.ambient_type = 2
    Lighting.reflection_intensity = 0
    Lighting.apply()

    -- Hands are not spawned in the first frame
    local f = function()
        for _, hand in ipairs(Hands.getHands()) do
            hand.destruct()
        end
    end

    Wait.frames(f, 2)
end

function module.create8p()
    common()
    Info.number_of_players = { 2, 8 }
    Physics.play_area = 1
    Wait.frames(spawnStuff8p, 5)
end

function module.create2p()
    common()
    Info.number_of_players = { 2, 2 }
    Wait.frames(spawnStuff2p, 5)
end

return module
