local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicD")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Light of Destruction"
    o.setCodePrefix = "LODT-EN"
    o.setNameUrl = "Light of Destruction"
    o.releaseDate = "2008-05-13"
    o.packTextures = imageHost .. "/textures/packs/coresets/027-LODT.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/027-LODT.png"

    return o
end

return PackGenerator
