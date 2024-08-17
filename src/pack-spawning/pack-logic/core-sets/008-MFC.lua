local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicA")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Magician's Force"
    o.setCodePrefix = "MFC-"
    o.setNameUrl = "Magician's Force"
    o.releaseDate = "2003-10-10"
    o.packTextures = imageHost .. "/textures/packs/coresets/008-MFC.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/008-MFC.png"

    return o
end

return PackGenerator
