local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicG")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Rise of the Duelist"
    o.setCodePrefix = "ROTD-EN"
    o.setNameUrl = "Rise of the Duelist"
    o.releaseDate = "2020-08-07"
    o.packTextures = imageHost .. "/textures/packs/coresets/076-ROTD.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/076-ROTD.png"

    return o
end

return PackGenerator
