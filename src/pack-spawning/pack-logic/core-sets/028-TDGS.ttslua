local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicD")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "The Duelist Genesis"
    o.setCodePrefix = "TDGS-EN"
    o.setNameUrl = "The Duelist Genesis"
    o.releaseDate = "2008-09-02"
    o.packTextures = imageHost .. "/textures/packs/coresets/028-TDGS.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/028-TDGS.png"

    return o
end

return PackGenerator
