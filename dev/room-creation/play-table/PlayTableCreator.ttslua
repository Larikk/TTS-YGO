local matCreator = require("TTS-YGO/dev/room-creation/play-table/MatCreator")
local calculatorJson = require("TTS-YGO/dev/room-creation/play-table/CalculatorJson")
local util = require("TTS-YGO/dev/room-creation/Util")


local module = {}

local v = Vector

local tableScale = v(0.8, 1, 0.7)
local plateScale = v(0.18, 0.20, 0.1575)

local function createCoin(pos, rotation)
    local spawnParams = {
        type = "Quarter",
        position = pos + v(0, 5, 0),
        rotation = rotation,
        sound = false,
        snap_to_grid = true,
    }
    spawnObject(spawnParams)
end

local function createInfiniteBag(pos, rotation, content)
    local spawnParams = {
        type = "Infinite_Bag",
        position = pos + v(0, 5, 0),
        rotation = rotation,
        sound = false,
        snap_to_grid = true,
        callback_function = function(bag)
            local spawnParams = {
                type = content,
                position = pos + v(0, 10, 0),
                rotation = rotation,
                sound = false,
                snap_to_grid = true,
            }
            spawnObject(spawnParams)
        end
    }
    spawnObject(spawnParams)
end

local function createCalculator(pos, rotation)
    local spawnParams = {
        json              = calculatorJson,
        position          = pos + v(0, 5, 0),
        rotation          = rotation,
        --scale             = cardGridScale,
        sound             = false,
        snap_to_grid      = true,
        callback_function = function(calculator)
            local f = function()
                calculator.setLock(true)
            end
            Wait.time(f, 2)
        end
    }
    spawnObjectJSON(spawnParams)
end

local function createHand(pos, rotation, color)
    local spawnParams = {
        type = "HandTrigger",
        position = pos + v(0, 5, 0),
        rotation = rotation,
        scale = v(15, 7.5, 5),
        sound = false,
        snap_to_grid = true,
        callback_function = function(zone)
            zone.setValue(color)
        end
    }
    spawnObject(spawnParams)
end

local function createPlate(table, color1, color2)
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
        matCreator.create(plate.getPosition(), plate.getRotation())

        local size = v(plate.getBoundsNormalized().size)

        local pos = util.relativeLocalToWorldPosition2D(plate, size, -0.75, 0.3)
        local rotation = plate.getRotation()
        createCalculator(pos, rotation)

        pos = util.relativeLocalToWorldPosition2D(plate, size, 0.75, -0.3)
        rotation = rotation + v(0, 180, 0)
        createCalculator(pos, rotation)

        createCoin(plate.getPosition(), plate.getRotation())

        pos = util.relativeLocalToWorldPosition2D(plate, size, 0.7, 0.3)
        createInfiniteBag(pos, plate.getRotation(), "Quarter")

        pos = util.relativeLocalToWorldPosition2D(plate, size, 0.8, 0.2)
        createInfiniteBag(pos, plate.getRotation(), "Die_6")

        pos = util.relativeLocalToWorldPosition2D(plate, size, 0, -0.85)
        createHand(pos, plate.getRotation(), color1)

        pos = util.relativeLocalToWorldPosition2D(plate, size, 0, 0.85)
        createHand(pos, plate.getRotation() + v(0, 180, 0), color2)

        plate.setLuaScript(util.getNonInteractableLuaScript())
    end

    -- Wait insteal of callback because the plate needs to fall down on the table
    Wait.time(f, 1)
end

local function createTable(pos, rotation, color1, color2)
    local spawnParams = {
        type = "Custom_Assetbundle",
        position = pos,
        rotation = rotation,
        scale = tableScale,
        sound = false,
        snap_to_grid = true,
        callback_function = function(table) createPlate(table, color1, color2) end
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

function module.create(pos, rotation, color1, color2)
    createTable(pos, rotation, color1, color2)
end

return module
