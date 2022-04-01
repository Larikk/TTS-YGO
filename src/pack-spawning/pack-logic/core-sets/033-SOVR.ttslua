local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicD")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Stardust Overdrive"
    o.setCodePrefix = "SOVR-EN"
    o.setNameUrl = "Stardust Overdrive"
    o.releaseDate = "2009-11-17"
    o.packTextures = imageHost .. "/textures/packs/coresets/033-SOVR.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/033-SOVR.png"

    return o
end

return PackGenerator
