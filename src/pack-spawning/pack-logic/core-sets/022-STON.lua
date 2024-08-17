local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicC")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Strike of Neos"
    o.setCodePrefix = "STON-EN"
    o.setNameUrl = "Strike of Neos"
    o.releaseDate = "2007-02-28"
    o.packTextures = imageHost .. "/textures/packs/coresets/022-STON.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/022-STON.png"

    return o
end

return PackGenerator
