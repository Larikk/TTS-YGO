local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicA")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Dark Crisis"
    o.setCodePrefix = "DCR-EN"
    o.setNameUrl = "Dark Crisis"
    o.releaseDate = "2003-12-01"
    o.packTextures = imageHost .. "/textures/packs/coresets/009-DCR.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/009-DCR.png"

    return o
end

return PackGenerator
