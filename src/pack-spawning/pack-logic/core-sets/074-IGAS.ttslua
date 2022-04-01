local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicF")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Ignition Assault"
    o.setCodePrefix = "IGAS-EN"
    o.setNameUrl = "Ignition Assault"
    o.releaseDate = "2020-01-31"
    o.packTextures = imageHost .. "/textures/packs/coresets/074-IGAS.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/074-IGAS.png"

    return o
end

return PackGenerator
