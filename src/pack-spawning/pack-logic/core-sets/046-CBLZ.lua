local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicD")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Cosmo Blazer"
    o.setCodePrefix = "CBLZ-EN"
    o.setNameUrl = "Cosmo Blazer"
    o.releaseDate = "2013-01-25"
    o.packTextures = imageHost .. "/textures/packs/coresets/046-CBLZ.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/046-CBLZ.png"

    return o
end

return PackGenerator
