local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicG")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Photon Hypernova"
    o.setCodePrefix = "PHHY-EN"
    o.setNameUrl = "Photon Hypernova"
    o.releaseDate = "2023-02-10"
    o.packTextures = imageHost .. "/textures/packs/coresets/086-PHHY.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/086-PHHY.png"

    return o
end

return PackGenerator
