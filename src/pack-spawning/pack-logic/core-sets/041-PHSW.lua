local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicD")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Photon Shockwave"
    o.setCodePrefix = "PHSW-EN"
    o.setNameUrl = "Photon Shockwave"
    o.releaseDate = "2011-11-15"
    o.packTextures = imageHost .. "/textures/packs/coresets/041-PHSW.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/041-PHSW.png"

    return o
end

return PackGenerator
