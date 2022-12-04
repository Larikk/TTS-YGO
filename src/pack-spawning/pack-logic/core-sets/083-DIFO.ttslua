local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicG")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Dimension Force"
    o.setCodePrefix = "DIFO-EN"
    o.setNameUrl = "Dimension Force"
    o.releaseDate = "2022-05-20"
    o.packTextures = imageHost .. "/textures/packs/coresets/083-DIFO.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/083-DIFO.png"

    return o
end

return PackGenerator
