local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicE")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Circuit Break"
    o.setCodePrefix = "CIBR-EN"
    o.setNameUrl = "Circuit Break"
    o.releaseDate = "2017-10-20"
    o.packTextures = imageHost .. "/textures/packs/coresets/065-CIBR.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/065-CIBR.png"

    return o
end

return PackGenerator
