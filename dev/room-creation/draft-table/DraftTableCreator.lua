-- import:
--local c = require("TTS-YGO/dev/draft-table/DraftTableCreator")

local cardGridJson = require("TTS-YGO/dev/room-creation/draft-table/CardGrid")
local util = require("TTS-YGO/dev/room-creation/Util")

local module = {}

local v = Vector

local tableScale = v(3.50, 1.00, 2.00)
local plateScale = v(0.85, 0.20, 0.47)
local hiddenZoneScale = v(40, 15, 60)
local cardGridScale = v(9, 2, 9)

local function createCardGrid(zone)
    local size = zone.getScale()
    local pos = util.relativeLocalToWorldPosition2D(zone, size, -1, -1)
    local rotation = zone.getRotation()

    local spawnParams = {
        json              = cardGridJson,
        position          = pos,
        rotation          = rotation,
        scale             = cardGridScale,
        sound             = false,
        snap_to_grid      = true,
        callback_function = function(grid)
            local f = function()
                local size = v(grid.getBoundsNormalized().size)
                util.moveForwards(grid, size.z / 2)
                util.moveRight(grid, size.x / 2)
                Wait.time(function() grid.setLock(true) end, 2)
            end
            Wait.time(f, 2)
        end
    }
    spawnObjectJSON(spawnParams)
end

local function createHiddenZone(pos, rotation, left, color)
    local spawnParams = {
        type = "FogOfWarTrigger",
        position = pos,
        rotation = rotation,
        scale = hiddenZoneScale,
        sound = false,
        snap_to_grid = true,
        callback_function = function(zone)
            zone.setValue(color)
            util.moveBackwards(zone, zone.getScale().z / 2)
            if left then util.moveLeft(zone, zone.getScale().x / 2) else util.moveRight(zone, zone.getScale().x / 2) end
            util.moveUp(zone, zone.getScale().y / 1.8)

            Wait.frames(function() createCardGrid(zone) end, 2)
        end
    }
    spawnObject(spawnParams)
end

local function createHiddenZones(plate)
    local color = util.getPlayerColors()
    local x2d = 1.0
    local y2d = 1.0
    local rotation = plate.getRotation()
    local size = plate.getBoundsNormalized().size

    for i = 1, 4 do
        local pos = util.relativeLocalToWorldPosition2D(plate, size, x2d, y2d)
        createHiddenZone(pos, rotation, true, color[i])
        x2d = x2d - 0.42
    end

    x2d = 1.0
    y2d = -1.0
    rotation = rotation + v(0, 180, 0)

    for i = 5, 8 do
        local pos = util.relativeLocalToWorldPosition2D(plate, size, x2d, y2d)
        createHiddenZone(pos, rotation, false, color[i])
        x2d = x2d - 0.42
    end
end

local function createText(plate)
    local parentSize = plate.getBoundsNormalized().size
    local pos = util.relativeLocalToWorldPosition2D(plate, parentSize, -0.85, -0.2)

    local spawnParams = {
        type = "3DText",
        position = pos + v(0, 2, 0),
        rotation = plate.getRotation() + v(90, 0, -90),
        sound = false,
        snap_to_grid = true,
        callback_function = function(text)
            text.setValue("Cards spawn here")
            text.setColorTint("White")

            local size = 2.5
            text.setScale(v(size, size, size))
        end
    }
    spawnObject(spawnParams)
end

local function createTablet(plate)
    local parentSize = plate.getBoundsNormalized().size
    local pos = util.relativeLocalToWorldPosition2D(plate, parentSize, -0.8, 0.4)

    local spawnParams = {
        type = "Custom_Model",
        position = pos + v(0, 2, 0),
        rotation = plate.getRotation() + v(0, 90, 0),
        scale = v(1, 1, 1),
        sound = false,
        snap_to_grid = true,
    }
    local tablet = spawnObject(spawnParams)
    tablet.setCustomObject({
        mesh = "http://cloud-3.steamusercontent.com/ugc/1804229846313094263/6C41D40E9318D40586B21366DCE99988AA0D2400/",
        diffuse = "http://cloud-3.steamusercontent.com/ugc/1778353420788098738/AE7C918904D058E2358FEEE7B1B277ED3F9CD959/",
        material = 2,
        specular_intensity = 0,
        specular_sharpness = 2,
        freshnel_strength = 0,
        cast_shadows = true
    })
    tablet = tablet.reload()

    local f = function()
        tablet.setLock(true)
        tablet.setName("Yu-Gi-Oh! TTS Edition")
        tablet.setLuaScript(util.getTabletLuaScript())
    end

    Wait.time(f, 1)
end

local function createPlate(table)
    local spawnParams = {
        type = "Custom_Model",
        position = table.getPosition() + v(0, 0.1, 0),
        rotation = table.getRotation(),
        scale = plateScale,
        sound = false,
        snap_to_grid = true,
    }
    local plate = spawnObject(spawnParams)
    plate.setCustomObject({
        mesh = "http://cloud-3.steamusercontent.com/ugc/1778353420788097296/661D8FFE6699A4D022FB10D87979B2028D8D1806/",
        diffuse = "http://cloud-3.steamusercontent.com/ugc/1778353420788097351/EEF2FF28224A83EB29EC7D5B3CA728782F1554FC/",
        collider = "http://cloud-3.steamusercontent.com/ugc/1778353420788097412/661D8FFE6699A4D022FB10D87979B2028D8D1806/",
        type = 4,
        material = 1,
        specular_intensity = 0,
        specular_sharpness = 3,
    })

    local f = function()
        plate.locked = true
        createHiddenZones(plate)
        createText(plate)
        createTablet(plate)
        plate.setLuaScript(util.getNonInteractableLuaScript())
    end

    -- Wait insteal of callback because the plate needs to fall down on the table
    Wait.time(f, 1)
end

local function createTable(pos, rotation)
    local spawnParams = {
        type = "Custom_Assetbundle",
        position = pos,
        rotation = rotation,
        scale = tableScale,
        sound = false,
        snap_to_grid = true,
        callback_function = function(table) createPlate(table) end
    }
    local table = spawnObject(spawnParams)
    table.locked = true
    table.setCustomObject({
        assetbundle = "http://cloud-3.steamusercontent.com/ugc/1778353420788097497/1ED59A7E6C52632AF229D6017BB616F051EAE049/",
        type = 4,
        material = 1,
    })
    table.setLuaScript(util.getNonInteractableLuaScript())
end

function module.create(pos, rotation)
    createTable(pos, rotation)
end

return module
